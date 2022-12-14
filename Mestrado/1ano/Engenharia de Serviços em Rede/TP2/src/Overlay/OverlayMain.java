
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;


public class OverlayMain {

    private static InetAddress bootStrapperIP;
    private static OVRTransmitter transmitter;
    private static OverlayConList connectionList;
    public static final short bootStrapperPort = 5000;
    public static final short overlayPort = 5010;
    private static String myMachineName;
    private static boolean awaitingRTT = false;
    private static short RTTNumTry = 0;
    private static final long MAXRTTDELAYMS = 100;
    private static boolean fakeLag = false;

    static {
        try {
            myMachineName = InetAddress.getLocalHost().getHostName();
        } catch (Exception e) {
            String[] errorList = e.toString().split(":");
            myMachineName = errorList[1].strip();
        }
    }

    public static void main(String[] args) {

        if (args.length != 1){
            Logger.logError("Erro de argumentos");
            System.exit(1);
        }

        try{
            bootStrapperIP = InetAddress.getByName(args[0]);

            if(bootStrapperIP.isAnyLocalAddress() || bootStrapperIP.isLoopbackAddress()){
                //START BOOTSTRAPPER
                Logger.logCustomMessage("Starting BootStrapper",true);
                Thread t = new Thread(new BootStrapper(bootStrapperPort,1));
                t.start();
            }

            int numTry = 1;
            transmitter = new OVRTransmitter(overlayPort,myMachineName);
            connectionList = new OverlayConList(transmitter);
            while (!connectionList.getNeighboursInfo(bootStrapperIP, bootStrapperPort) && numTry <= 3){
                TimeUnit.MILLISECONDS.sleep(400);
                Logger.logCustomMessage("Failed... Retrying ("+numTry+"/3)",true);
                numTry++;
            }


            Logger.logCustomMessage("OverLay Active",true);
            Thread t = new Thread(new OverlayMenu());
            t.start();
            Thread rtt = new Thread(new OverlayRTTTester());
            rtt.start();
        } catch (UnknownHostException e){
            Logger.logError("Invalid IP");
            System.exit(1);
        } catch (SocketException|InterruptedException e){
            Logger.logError(e.toString());
            System.exit(1);
        }


        while(true){

            try{
                OVRPacket receivedPacket = transmitter.receivePacket(true,0);
                String sourceName = receivedPacket.getSrcNode();

                if (fakeLag) Thread.sleep(50);

                switch (receivedPacket.getCmd()) {
                    case FLOOD -> {
                        String server = receivedPacket.getServerName();
                        if (!connectionList.isKnownServer(server)) {
                            connectionList.addNewServer(server, sourceName);
                            transmitter.sendSetMeAsDestination((short) 0);
                            connectionList.sendFloods(server, sourceName);
                        }
                    }

                    case SETASDESTINATION -> {
                        if (receivedPacket.getSeq() == 0){
                            connectionList.addNewDestination(sourceName);
                        }
                        else{
                            connectionList.destroyDestination(sourceName);
                        }

                    }

                    case SPEEDTEST -> {
                        String server = receivedPacket.getServerName();
                        long delay =  ChronoUnit.MILLIS.between(receivedPacket.getTimeStamp(),LocalDateTime.now());
                        connectionList.sendSpeedTestToAllDestinations(server, (short) (receivedPacket.getSeq()+1),receivedPacket.getTimeStamp());
                        connectionList.setServerDelay(server,delay,receivedPacket.getSeq());
                        connectionList.setConnectedServer(connectionList.getBestServer());
                    }

                    case RTT -> {
                        if(receivedPacket.getSeq() == 0){
                            transmitter.setDestPort(overlayPort);
                            transmitter.sendRtt(receivedPacket.getTimeStamp(),(short) 1);
                        } else if (receivedPacket.getSeq() == 1) {
                            long rttDelayMS = ChronoUnit.MILLIS.between(receivedPacket.getTimeStamp(),LocalDateTime.now());
                            awaitingRTT = false;
                            RTTNumTry = 0;
                            if (rttDelayMS > MAXRTTDELAYMS){
                                String connectedServer = connectionList.getConnectedServer();
                                connectionList.setServerDelay(connectedServer,Long.MAX_VALUE,Short.MAX_VALUE);
                                connectionList.setConnectedServer(connectionList.getBestServer());
                                if(connectedServer.equals(connectionList.getConnectedServerCon().getName()) || connectionList.getConnectedServerCon().getserverDelayMS() > MAXRTTDELAYMS){
                                    connectionList.findNewPathToServer();
                                }
                            }
                        }
                    }

                    case JOIN -> {
                        transmitter.sendAcknowledgement();
                        connectionList.createConnection(sourceName, transmitter.getDestIP());
                    }

                    case LEAVE -> {
                        transmitter.sendAcknowledgement();
                        connectionList.destroyConnection(sourceName);
                    }

                    case ACTIVATE -> connectionList.activateConnection(sourceName);
                    case DEACTIVATE -> connectionList.deactivateConnection(sourceName);
                    case DATA -> {
                        if (connectionList.getConnectedServerCon().getName().equals(sourceName))
                            connectionList.sendDataToAllActiveDestinations(receivedPacket.getData());
                    }
                }


            } catch (Exception e){
                Logger.logWarning(e.toString());
            }

        }

    }


    public static class OverlayRTTTester implements Runnable {

        private final int RTTRefreshRateMS = 5000;
        private final OVRTransmitter myTransmitter = new OVRTransmitter(overlayPort+1,Logger.machineName);

        public OverlayRTTTester() throws SocketException {
        }

        @Override
        public void run() {
            while(true){
                try {
                    Thread.sleep(RTTRefreshRateMS);
                    if(awaitingRTT && RTTNumTry > 1){
                        myTransmitter.setDestination(InetAddress.getByName("localhost"),overlayPort,Logger.machineName);
                        myTransmitter.sendRtt(LocalDateTime.now().minusSeconds(RTTRefreshRateMS/1000),(short) 1);
                        awaitingRTT = false;
                        RTTNumTry = 0;
                    }
                    else{
                        OverlayConnection serverCon = connectionList.getConnectedServerCon();
                        if(serverCon != null){
                            myTransmitter.setDestination(serverCon.getIp(),overlayPort,serverCon.getName());
                            myTransmitter.sendRtt(LocalDateTime.now(),(short) 0);
                            RTTNumTry++;
                            awaitingRTT = true;
                        }
                    }
                } catch (Exception e) {
                    Logger.logWarning("RTTTESTER: "+e);
                }
            }
        }
    }

    public static class OverlayMenu implements Runnable{


        OverlayMenu(){}
        @Override
        public void run() {
            Scanner input = new Scanner(System.in);
            while (true){
                printMenu();
                String line = input.nextLine();
                int op = -1;
                try{
                    op = Integer.parseInt(line);
                    if (op > 3 || op <= 0) throw new NumberFormatException();
                } catch (NumberFormatException e){
                    System.out.println("Invalid option");
                }

                switch (op){
                    case 1:
                        System.out.println(connectionList.connectionListToString());
                        break;
                    case 2:
                        System.out.println(transmitter.getLastReport());
                        break;
                    case 3:
                        if(fakeLag) fakeLag=false;
                        else fakeLag = true;
                        break;
                }
            }
        }

        private void printMenu(){
            String menu = "Overlay Menu:\n";
            menu+= "1 - Print Connection List\n";
            menu+= "2 - Print Traffic Report\n";
            menu+= "3 - Toggle Fake LAG ("+fakeLag+")";
            System.out.println(menu);
        }
    }
}
