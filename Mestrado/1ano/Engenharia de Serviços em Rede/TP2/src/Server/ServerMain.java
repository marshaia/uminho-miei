import java.net.InetAddress;
import java.time.LocalDateTime;

public class ServerMain {

    private static OVRTransmitter transmitter;
    private static OverlayConnection rootNode;
    private static ServerVideoStream videoStream;
    private static String videoFileName;
    private static boolean streamActive = false;
    private static byte[] sBuf = new byte[15360];
    private static int imagenb = 0; //image nb of the image currently transmitted
    static int MJPEG_TYPE = 26; //RTP payload type for MJPEG video
    static int FRAME_PERIOD = 40; //Frame period of the video to stream, in ms
    static int VIDEO_LENGTH = 500;

    public static void main(String args[]){

        if (args.length != 2 && args.length != 1){
            System.out.println("Erro de argumentos");
            return;
        }

        if (args.length == 2 ) {
            videoFileName = args[1];
            System.out.println("Servidor: VideoFileName indicado como parametro: " + videoFileName);
        } else  {
            videoFileName = "movie.Mjpeg";
            System.out.println("Servidor: parametro não foi indicado. VideoFileName = " + videoFileName);
        }

        try{
            videoStream = new ServerVideoStream(videoFileName);
            rootNode = new OverlayConnection(Logger.machineName,InetAddress.getByName(args[0]));
            transmitter = new OVRTransmitter(OverlayMain.overlayPort,Logger.machineName,rootNode.getIp(),OverlayMain.overlayPort,"OverlayPoint");
            OVRPacket receivedPacket;

            transmitter.sendJoinOverlay();
            Logger.logCustomMessage("Flooding Overlay Network...",true);
            transmitter.sendFloodMsg(Logger.machineName);
            Thread.sleep(3000);

            Logger.logCustomMessage("Pinging speed...",true);
            transmitter.sendSpeedTest(Logger.machineName,(short) 0,LocalDateTime.now());

            Logger.logCustomMessage("Streaming...",true);
            Thread t = new Thread(new ServerStreamer());
            t.start();
            Thread tSpeed = new Thread(new ServerSpeedTester());
            tSpeed.start();


            while (true){
                receivedPacket = transmitter.receivePacket(true,0);
                if(receivedPacket.getCmd().equals(OVRPacket.OVRCmd.ACTIVATE)) {
                    streamActive = true;
                }
                else if(receivedPacket.getCmd().equals(OVRPacket.OVRCmd.DEACTIVATE)) {
                    streamActive = false;
                }
                else if(receivedPacket.getCmd().equals(OVRPacket.OVRCmd.RTT)) {
                    transmitter.setDestPort(OverlayMain.overlayPort);
                    transmitter.sendRtt(receivedPacket.getTimeStamp(),(short) 1);
                }
            }

        }
        catch (Exception e){
            System.out.println("Server Error: ");
            e.printStackTrace();
            System.exit(1);
        }

    }


    private static class ServerStreamer implements Runnable{

        public ServerStreamer(){}

        @Override
        public void run() {

            try {
                while (true) {
                    if (imagenb < VIDEO_LENGTH) {
                        imagenb++;
                        int image_length = videoStream.getnextframe(sBuf);
                        //Builds an RTPpacket object containing the frame
                        RTPpacket rtp_packet = new RTPpacket(MJPEG_TYPE, imagenb, imagenb * FRAME_PERIOD, sBuf, image_length);
                        //get to total length of the full rtp packet to send
                        int packet_length = rtp_packet.getlength();
                        //retrieve the packet bitstream and store it in an array of bytes
                        byte[] packet_bits = new byte[packet_length];
                        rtp_packet.getpacket(packet_bits);
                        //send the packet as a DatagramPacket over the UDP socket
                        if (streamActive) transmitter.sendData(packet_bits, Logger.machineName);

                        Thread.sleep(FRAME_PERIOD);
                    } else {
                        //Reset video to loop
                        videoStream = new ServerVideoStream(videoFileName);
                        imagenb = 0;
                    }
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }


    private static class ServerSpeedTester implements Runnable{

        private final int speedTestRateMS = 10000;
        public ServerSpeedTester(){

        }
        @Override
        public void run() {
            while (true){
                try {
                    Thread.sleep(speedTestRateMS);
                    transmitter.sendSpeedTest(Logger.machineName, (short) 0, LocalDateTime.now());
                }catch (Exception e){
                    Logger.logWarning("SERVERSPEEDTESTER: "+e);
                }
            }
        }
    }
}
