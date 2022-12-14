import java.net.InetAddress;

public class OverlayConnection {
    private String name;
    private InetAddress ip;
    private boolean activeDestination = false;
    private long serverDelayMS = Long.MAX_VALUE;
    private short jumpsToServer = Short.MAX_VALUE;
    OverlayConnection(String name,InetAddress ip){
        this.name = name;
        this.ip = ip;
    }

    public void activateDestination(){
        this.activeDestination = true;
    }
    public void deactivateDestination(){
        this.activeDestination = false;
    }
    public boolean isActiveDestination() {return activeDestination;}

    public void setServerDelays(long serverDelayMS,short jumpsToServer) {
        this.serverDelayMS = serverDelayMS;
        this.jumpsToServer = jumpsToServer;
    }


    public String getName() {
        return name;
    }
    public InetAddress getIp() {
        return ip;
    }

    public long getserverDelayMS() {
        return serverDelayMS;
    }

    public short getJumpsToServer() {
        return jumpsToServer;
    }

    public String toString() {
        return name;
    }
}
