import org.json.simple.JSONObject;

import java.io.IOException;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class OVRTransmitter {
    private DatagramSocket socket;
    private InetAddress destIP = null;
    private int destPort = -1;
    private String destNodeName = "";
    private String myNodeName = "";
    private OVRStatistics stats;

    public OVRTransmitter(int myPort, String myName) throws SocketException {
        this.socket = new DatagramSocket(myPort);
        this.myNodeName = myName;
        this.stats = new OVRStatistics(1000);
        Thread t = new Thread(this.stats);
        t.start();
    }

    public OVRTransmitter(int myPort,String myName, InetAddress destIP, int destPort, String destNodeName) throws SocketException {
        this.socket = new DatagramSocket(myPort);
        this.destIP = destIP;
        this.destPort = destPort;
        this.destNodeName = destNodeName;
        this.myNodeName = myName;
        this.stats = new OVRStatistics(1000);
        Thread t = new Thread(this.stats);
        t.start();
    }

    public void setDestination(InetAddress destIP, int destPort, String destNodeName){
        this.destIP = destIP;
        this.destPort = destPort;
        this.destNodeName = destNodeName;
    }

    public void setDestPort(int destPort) {
        this.destPort = destPort;
    }

    public InetAddress getDestIP() {
        return destIP;
    }

    public int getDestPort() {
        return destPort;
    }

    public String getDestNodeName() {
        return destNodeName;
    }

    public OVRPacket receivePacket(boolean changeDestination, int timeoutMilis) throws IOException, IllegalArgumentException, SocketTimeoutException {
        byte[] receivedBytes = new byte[OVRPacket.maxPacketSize];
        DatagramPacket receivedPacket = new DatagramPacket(receivedBytes,receivedBytes.length);
        socket.setSoTimeout(timeoutMilis);
        socket.receive(receivedPacket);

        OVRPacket res = OVRPacket.deserialize(receivedPacket.getData());
        Logger.logOVRPacket(res,false);
        this.stats.addIncomingBytes(res.getSrcNode(),res.getPacketSize());

        if(changeDestination){
            destIP = receivedPacket.getAddress();
            destPort = receivedPacket.getPort();
            destNodeName = res.getSrcNode();
        }

        return res;
    }

    private void sendPacket(OVRPacket packet) throws IOException{
        if(destIP == null || destPort == -1)
            throw new IOException("Destination IP/Port not defined");

        byte[] packetBytes = packet.serialize();
        DatagramPacket sentPacket = new DatagramPacket(packetBytes,packetBytes.length,destIP,destPort);
        Logger.logOVRPacket(packet,true);
        this.stats.addOutgoingBytes(packet.getDestNode(),packet.getPacketSize());
        socket.send(sentPacket);
    }

    public void sendData(byte[] data, String serverName) throws IOException {
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.DATA,this.myNodeName,this.destNodeName,serverName,(short)0,null ,data));
    }

    public void sendJSON(JSONObject obj) throws IOException{
        sendData(obj.toJSONString().getBytes(StandardCharsets.UTF_8),"");
    }

    public void sendActivate() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.ACTIVATE,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public void sendDeactivate() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.DEACTIVATE,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public void sendNeighboursInfoRequest() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.INITREQUEST,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public void sendFloodMsg(String serverName) throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.FLOOD,this.myNodeName,this.destNodeName, serverName,(short) 0,null,null));
    }

    public void sendSpeedTest(String serverName,short seq,LocalDateTime timeFromServer) throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.SPEEDTEST,this.myNodeName,this.destNodeName, serverName,seq,timeFromServer,null));
    }

    public void sendSetMeAsDestination(short seq) throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.SETASDESTINATION,this.myNodeName,this.destNodeName, "",seq,null,null));
    }

    public void sendRtt(LocalDateTime date,short seq) throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.RTT,this.myNodeName,this.destNodeName, "",seq,date,null));
    }

    public void sendJoinOverlay() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.JOIN,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public void sendLeaveOverlay() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.LEAVE,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public void sendAcknowledgement() throws IOException{
        sendPacket(new OVRPacket(OVRPacket.OVRCmd.ACK,this.myNodeName,this.destNodeName, "",(short) 0,null,null));
    }

    public String getLastReport(){
        return this.stats.getLastReport();
    }


    private class OVRStatistics implements Runnable {

        private Map<String,Long> incoming;
        private Map<String,Long> outgoing;
        private final long refreshRateMS;
        private String lastReport = "Not Initialized";
        private ReentrantReadWriteLock l = new ReentrantReadWriteLock();

        public OVRStatistics(long refreshRateMS){
            this.refreshRateMS = refreshRateMS;
            this.incoming = new HashMap<>();
            this.outgoing = new HashMap<>();
        }

        @Override
        public void run() {

            while (true){
                try {
                    Thread.sleep(refreshRateMS);
                    this.updateReport();
                    this.cleanStats();
                } catch (InterruptedException e) {
                    Logger.logWarning("TRANSMITTER STATISTIC: "+e);
                }
            }

        }


        public void addIncomingBytes(String name,long bytes){
            try{
                l.writeLock().lock();
                if(incoming.containsKey(name))
                    incoming.put(name,incoming.get(name) + bytes);
                else
                    incoming.put(name,bytes);
            } finally {
                l.writeLock().unlock();
            }
        }

        public void addOutgoingBytes(String name,long bytes){
            try{
                l.writeLock().lock();
                if(outgoing.containsKey(name))
                    outgoing.put(name,outgoing.get(name) + bytes);
                else
                    outgoing.put(name,bytes);
            } finally {
                l.writeLock().unlock();
            }
        }

        public void cleanStats(){
            this.incoming = new HashMap<>();
            this.outgoing = new HashMap<>();
        }

        public String printTrafficValue(long bytes){
            float seconds = refreshRateMS/1000;
            int unit = 0; // 0-b/s  1-kb/s  2-mb/s  3-gb/s
            float dataPerSecond = bytes/seconds;

            while(dataPerSecond > 1024){
                dataPerSecond = dataPerSecond /1024;
                unit++;
            }

            String res = String.format("%.02f",dataPerSecond)+" ";
            switch (unit){
                case 0: res += "B/s"; break;
                case 1: res += "KB/s"; break;
                case 2: res += "MB/s"; break;
                case 3: res += "GM/s"; break;
            }

            return res;
        }

        public void updateReport(){
            try{
                l.readLock().lock();
                StringBuilder sb = new StringBuilder("TRAFFIC REPORT: (Last "+this.refreshRateMS/1000+" seconds)\n");
                sb.append("INCOMING:\n");
                for (Map.Entry<String,Long> entry : this.incoming.entrySet()){
                    sb.append(entry.getKey()).append(": ").append(printTrafficValue(entry.getValue())).append(", ");
                }
                sb.append("\n");
                sb.append("OUTGOING:\n");
                for (Map.Entry<String,Long> entry : this.outgoing.entrySet()){
                    sb.append(entry.getKey()).append(": ").append(printTrafficValue(entry.getValue())).append(", ");
                }
                sb.append("\n");

                this.lastReport = sb.toString();
            } finally {
                l.readLock().unlock();
            }
        }

        public String getLastReport() {
            return lastReport;
        }
    }
}
