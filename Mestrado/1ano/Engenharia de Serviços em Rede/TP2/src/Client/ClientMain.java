import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.InetAddress;
import java.net.SocketTimeoutException;
import java.util.Scanner;

public class ClientMain {

    private static OVRTransmitter transmitter;
    private static OverlayConnection streamSource;

    public static void main(String[] args){

        if (args.length != 1){
            System.out.println("Erro de argumentos");
            return;
        }

        try{
            ClientStreamFetcher diplay = new ClientStreamFetcher();
            streamSource = new OverlayConnection(Logger.machineName,InetAddress.getByName(args[0]));
            transmitter = new OVRTransmitter(OverlayMain.overlayPort,Logger.machineName,streamSource.getIp(),OverlayMain.overlayPort,"OverlayPoint");
            transmitter.sendJoinOverlay();


            Scanner input = new Scanner(System.in);
            while (true){
                printMenu();
                String line = input.nextLine();
                int op = -1;
                try{
                    op = Integer.parseInt(line);
                    if (op > 1 || op < 0) throw new NumberFormatException();
                } catch (NumberFormatException e){
                    System.out.println("Invalid option");
                }

                switch (op) {
                    case 0 -> {
                        transmitter.sendLeaveOverlay();
                        System.out.println("Bye bye");
                        System.exit(0);
                    }
                    case 1 -> {
                        System.out.println("Starting stream...");
                        transmitter.sendActivate();

                        OVRPacket ackPack = transmitter.receivePacket(true,500);
                        if (ackPack.getCmd().equals(OVRPacket.OVRCmd.ACK) || ackPack.getCmd().equals(OVRPacket.OVRCmd.DATA)){
                            Thread t = new Thread(diplay);
                            t.start();

                            System.out.println("Close Window to return");

                            t.join();
                            transmitter.sendDeactivate();
                        }
                        else{
                            System.out.println("Failed to Activate Stream.");
                            System.out.println("This might be due to the Overlay not having a connected Server");
                        }
                    }
                }
            }
        }
        catch (HeadlessException e){
            Logger.logCustomMessage("DISPLAY IS NOT SET. USE COMMAND 'export DISPLAY=:0.0' to fix it",true);
            System.exit(1);
        }
        catch (Exception e){
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static void printMenu(){
        String menu = "Connected to: "+streamSource.getIp().toString()+"\nOVR Stream-Client:\n";
        menu+= "1 - Watch Stream\n";
        menu+= "0 - Exit Client";
        System.out.println(menu);
    }

    private static class ClientStreamFetcher implements Runnable{
        JFrame f = new JFrame("Stream");
        JPanel mainPanel = new JPanel();
        JLabel iconLabel = new JLabel();
        private ImageIcon icon;
        private boolean streamOn;

        public ClientStreamFetcher(){
            mainPanel.add(iconLabel);
            iconLabel.setBounds(0,0,380,280);
            f.getContentPane().add(mainPanel, BorderLayout.CENTER);
            f.setSize(new Dimension(390,320));
            f.addWindowListener(new WindowAdapter() {
                public void windowClosing(WindowEvent e) {
                    streamOn = false;
                }
            });
        }
        @Override
        public void run() {
            try{
                streamOn = true;
                f.setVisible(true);

                while (streamOn){
                    try{
                        OVRPacket receivedPacket = transmitter.receivePacket(true,3000);
                        if(receivedPacket.getCmd().equals(OVRPacket.OVRCmd.DATA)){
                            RTPpacket rtp_packet = new RTPpacket(receivedPacket.getData(), receivedPacket.getData().length);

                            //get the payload bitstream from the RTPpacket object
                            int payload_length = rtp_packet.getpayload_length();
                            byte [] payload = new byte[payload_length];
                            rtp_packet.getpayload(payload);

                            //get an Image object from the payload bitstream
                            Toolkit toolkit = Toolkit.getDefaultToolkit();
                            Image image = toolkit.createImage(payload, 0, payload_length);

                            //display the image as an ImageIcon object
                            icon = new ImageIcon(image);
                            iconLabel.setIcon(icon);
                        }
                    } catch (SocketTimeoutException e) {
                        if (streamOn) Logger.logCustomMessage("Stream Hanged, trying to reconnect...",true);
                        else Logger.logCustomMessage("Exited with Connection Problem",true);
                    }
                }
            } catch (Exception e){
                e.printStackTrace();
                Logger.logWarning("STREAM FETCHER: "+e);
            }

        }
    }
}
