import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.net.InetAddress;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OverlayConList {

    private Map<String, OverlayConnection> connectionList = new HashMap<>();
    private Map<String, String> serverList = new HashMap<>();
    private Map<String, String> destinationList = new HashMap<>();
    private String connectedServer = "";
    private boolean connectedServerActive = false;
    private OVRTransmitter transmitter;

    public OverlayConList(OVRTransmitter transmitter){
        this.transmitter = transmitter;
    }

    public void createConnection(String name, InetAddress ip){
        this.connectionList.put(name,new OverlayConnection(name,ip));
        this.addNewDestination(name);
    }

    public void destroyConnection(String name){
        this.connectionList.remove(name);
        this.destinationList.remove(name);
    }

    public boolean isKnownServer(String serverName){
        return this.serverList.containsKey(serverName);
    }

    public void addNewServer(String serverName,String connectionName) {
        Logger.logCustomMessage("New Server: '"+serverName+"'. Path: '"+connectionName+"'",false);
        this.serverList.put(serverName,connectionName);
    }

    public void changeServerConnection(String serverName,String connectionName) {
        this.serverList.remove(serverName);
        this.serverList.put(serverName,connectionName);
    }

    public String getConnectedServer() {
        return connectedServer;
    }

    public void findNewPathToServer() throws IOException {
        List<String> ignoreCons = new ArrayList<>();
        ignoreCons.add(this.serverList.get(this.connectedServer));
        ignoreCons.addAll(this.destinationList.keySet());

        for (Map.Entry<String,OverlayConnection> con: this.connectionList.entrySet()){
            if (!ignoreCons.contains(con.getKey())){
                Logger.logCustomMessage("Changing Server Path to '"+con.getKey()+"'",false);
                boolean reconnectNeeded = false;
                if (connectedServerActive){
                    this.deactivateServerConnection();
                    reconnectNeeded = true;
                }
                transmitter.sendSetMeAsDestination((short)1);
                this.changeServerConnection(this.connectedServer,con.getValue().getName());
                transmitter.setDestination(con.getValue().getIp(),OverlayMain.overlayPort,con.getValue().getName());
                transmitter.sendSetMeAsDestination((short)0);
                this.setConnectedServer(this.connectedServer);
                if (reconnectNeeded)
                    this.activateServerConnection();
                break;
            }
        }
    }

    public OverlayConnection getConnectedServerCon(){
        if(connectedServer.isEmpty()) return null;
        return this.connectionList.get(this.serverList.get(connectedServer));
    }

    public void activateServerConnection() throws IOException {
        OverlayConnection con = this.getConnectedServerCon();
        if(con != null){
            transmitter.setDestination(con.getIp(),OverlayMain.overlayPort,con.getName());
            transmitter.sendActivate();
            this.connectedServerActive = true;
        }
        else
            Logger.logCustomMessage("Tried to activate a NULL server",false);

    }

    public void deactivateServerConnection() throws IOException {
        OverlayConnection con = this.getConnectedServerCon();
        if(con != null){
            transmitter.setDestination(con.getIp(),OverlayMain.overlayPort,con.getName());
            transmitter.sendDeactivate();
            this.connectedServerActive = false;
        }
        else
            Logger.logCustomMessage("Tried to activate a NULL server",false);
    }

    public void setServerDelay(String serverName, long serverDelay, short jumpsToServer){
        this.connectionList.get(this.serverList.get(serverName)).setServerDelays(serverDelay,jumpsToServer);
    }

    public String getBestServer(){
        long maxDelay = Long.MAX_VALUE;
        String bestServer = "";
        for(Map.Entry<String,String> serverEntry : this.serverList.entrySet()){
            long actDelay = this.connectionList.get(serverEntry.getValue()).getserverDelayMS();
            if (actDelay <= maxDelay){
                maxDelay = actDelay;
                bestServer = serverEntry.getKey();
            }
        }
        Logger.logCustomMessage("Best Server: '"+bestServer+"'", false);
        return bestServer;
    }

    public void setConnectedServer(String serverName) throws IOException {
        Logger.logCustomMessage("Setting '"+serverName+"' as connected Server", false);
        boolean reconnectNeeded = false;
        if (this.connectedServerActive && !this.connectedServer.equals(serverName)){
            this.deactivateServerConnection();
            reconnectNeeded = true;
        }
        this.connectedServer = serverName;
        if (reconnectNeeded){
            this.activateServerConnection();
        }
    }

    public void activateConnection(String connectionName) throws IOException {
        if(this.destinationList.containsKey(connectionName)){
            this.connectionList.get(connectionName).activateDestination();

            if(!connectedServerActive){
                this.activateServerConnection();
            }

            if(connectedServerActive && !connectedServer.isEmpty()){
                transmitter.sendAcknowledgement();
            }
        }
    }

    public void deactivateConnection(String connectionName) throws IOException {
        if(this.destinationList.containsKey(connectionName)){
            this.connectionList.get(connectionName).deactivateDestination();

            if(checkAllDestinationDeactivated())
                this.deactivateServerConnection();
        }
    }

    public void sendFloods(String serverName, String connectionNameToIgnore) throws IOException{
        for (OverlayConnection con : this.connectionList.values()) {
            if (!con.getName().equals(connectionNameToIgnore)) {
                transmitter.setDestination(con.getIp(),OverlayMain.overlayPort,con.getName());
                transmitter.sendFloodMsg(serverName);
            }
        }
    }

    public void sendSpeedTestToAllDestinations(String serverName, short seq, LocalDateTime date) throws IOException{
        for(String dest : this.destinationList.values()){
            OverlayConnection con = this.connectionList.get(dest);
            transmitter.setDestination(con.getIp(),OverlayMain.overlayPort,con.getName());
            transmitter.sendSpeedTest(serverName,seq,date);
        }
    }

    public void addNewDestination(String connectionName){
        Logger.logCustomMessage("New Destination: '"+connectionName+"'", false);
        this.destinationList.put(connectionName,connectionName);
    }

    public void destroyDestination(String connectionName){
        Logger.logCustomMessage("Forgetting Destination: '"+connectionName+"'", false);
        this.destinationList.remove(connectionName);
    }

    public boolean checkAllDestinationDeactivated(){
        boolean allDeactivated = true;
        for (OverlayConnection con : this.connectionList.values()){
            if (con.isActiveDestination()){
                allDeactivated = false;
                break;
            }
        }
        return allDeactivated;
    }

    public void sendDataToAllActiveDestinations(byte[] data) throws IOException {
        for (OverlayConnection con: this.connectionList.values()){
            if (con.isActiveDestination()) {
                transmitter.setDestination(con.getIp(),OverlayMain.overlayPort,con.getName());
                transmitter.sendData(data,connectedServer);
            }
        }
    }










    public String connectionListToString(){
        StringBuilder res = new StringBuilder("--------- CONNECTION LIST ("+Logger.machineName+") ---------\n\n");

        //CONNECTED SERVER
        if(connectedServer.isEmpty()){
            res.append("NO CONNECTED SERVER\n");
        }
        else{
            res.append("CONNECTED SERVER ");
            if (connectedServerActive) res.append("(ACTIVE): ");
            else res.append("(DEACTIVATED): ");
            res.append(connectedServer).append("\n");
        }
        res.append("\n");

        //SERVER LIST
        res.append("KNOWN SERVERS:\n");
        for (Map.Entry<String,String> serverEntry : this.serverList.entrySet()) {
            res.append(serverEntry.getKey().toString()).append(": ");
            res.append(serverEntry.getValue().toString());
            res.append(" Delay:").append(this.connectionList.get(serverEntry.getValue()).getserverDelayMS()).append("ms");
            res.append(" Jumps to Server:").append(this.connectionList.get(serverEntry.getValue()).getJumpsToServer()).append("\n");
        }
        res.append("\n");

        // DESTINATIONS
        res.append("DESTINATIONS:\n");
        for (String dest : this.destinationList.values()){
            OverlayConnection con = this.connectionList.get(dest);
            res.append(con);
            if (con.isActiveDestination()) res.append(" (ACTIVE), ");
            else res.append(" (DEACTIVATED), ");
        }
        res.append("\n");


        // CONNECTIONS
        res.append("POSSIBLE CONNECTIONS:\n");
        for (OverlayConnection con : this.connectionList.values()) {
            res.append(con).append(", ");
        }
        res.append("\n");

        return res.toString();
    }

    public boolean getNeighboursInfo (InetAddress bootStrapperIp,short bootStrapperPort){
        try{
            Logger.logCustomMessage("Contacting BootStrapper",true);
            this.transmitter.setDestination(bootStrapperIp,bootStrapperPort,"BootStrapper");
            this.transmitter.sendNeighboursInfoRequest();

            OVRPacket receivedInfo = this.transmitter.receivePacket(true,500);
            JSONParser parser = new JSONParser();
            JSONObject data = (JSONObject) parser.parse(StandardCharsets.UTF_8.decode(ByteBuffer.wrap(receivedInfo.getData())).toString());

            //INSERT ALIAS IN MAP
            data.forEach((k,v) -> {
                try {
                    this.connectionList.put(k.toString(),new OverlayConnection(k.toString(),InetAddress.getByName(v.toString())));
                } catch (IOException e) {
                    Logger.logError("Invalid IP '"+v.toString()+"'");
                }
            });

            return true;
        } catch (IOException | ParseException e){
            Logger.logError(e.toString());
        }
        return false;
    }


}
