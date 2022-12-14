import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;

public class OVRPacket {

    public static enum OVRCmd {
        JOIN,       //Join Overlay
        LEAVE,      //Leave Overlay
        ACTIVATE,   //Activate Stream
        DEACTIVATE, //Deactivate Stream
        INITREQUEST,    //Request NodeInfo
        DATA,       //Data Packet
        FLOOD,      //Flood Packet
        SPEEDTEST,
        SETASDESTINATION,
        RTT,
        ACK,        //Acknowledgement
    }


    private static final short maxDataSize = 30720;
    private static final short maxHeaderSize = 256;
    private static final short maxStringSize = 32;
    public static final short maxPacketSize = maxDataSize + maxHeaderSize;

    private short headerSize = 0;
    private boolean hasData = false;
    private OVRCmd cmd;
    private String srcNode = "";
    private String destNode = "";
    private String serverName = "";
    private short seq = 0;
    private LocalDateTime timeStamp = LocalDateTime.now();
    private short dataSize = 0;
    private byte[] data = null;


    public OVRPacket(OVRCmd cmd,String srcNode,String destNode,String serverName,short seq,LocalDateTime timeStamp,byte[] data)
            throws OVRArgumentTooLargeException, OVRHeaderTooLargeException, OVRDataTooLargeException {

        this.cmd = cmd;
        if(srcNode != null) this.srcNode = srcNode;
        if(destNode != null) this.destNode = destNode;
        if(serverName != null) this.serverName = serverName;
        this.seq = seq;
        if(timeStamp != null) this.timeStamp = timeStamp;
        if(data != null) {
            if(data.length > maxDataSize) throw new OVRDataTooLargeException("Data Size "+data.length+" too large");
            this.data = data;
            this.dataSize = (short) data.length;
            this.hasData = true;
        }

        if(this.srcNode.length() > maxStringSize) throw new OVRArgumentTooLargeException("srcNode: '"+this.srcNode+"' too large. (Max "+maxStringSize+" characters)");
        if(this.destNode.length() > maxStringSize) throw new OVRArgumentTooLargeException("destNode: '"+this.destNode+"' too large. (Max "+maxStringSize+" characters)");
        if(this.serverName.length() > maxStringSize) throw new OVRArgumentTooLargeException("serverName: '"+this.serverName+"' too large. (Max "+maxStringSize+" characters)");

        short headerSize = 0;
        headerSize += this.cmd.toString().length() + 1;
        headerSize += this.srcNode.length() + 1;
        headerSize += this.destNode.length() + 1;
        headerSize += this.serverName.length() + 1;
        headerSize += Short.toString(this.seq).length() + 1;
        headerSize += this.timeStamp.toString().length() + 1;

        if (headerSize > maxHeaderSize) throw new OVRHeaderTooLargeException("Header Size "+headerSize+" too large");
        this.headerSize = headerSize;
    }
    private OVRPacket(){

    }

    public byte[] serialize(){
        short packetSize = (short) (headerSize + dataSize + 6);
        byte[] byteArr = new byte[packetSize];
        ByteBuffer buff = ByteBuffer.wrap(byteArr);

        buff.putShort(headerSize);
        buff.putChar(hasData ? 'Y' : 'N');

        buff.put(this.cmd.toString().concat("\n").getBytes(StandardCharsets.UTF_8));
        buff.put(this.srcNode.concat("\n").getBytes(StandardCharsets.UTF_8));
        buff.put(this.destNode.concat("\n").getBytes(StandardCharsets.UTF_8));
        buff.put(this.serverName.concat("\n").getBytes(StandardCharsets.UTF_8));
        buff.put(String.valueOf(seq).concat("\n").getBytes(StandardCharsets.UTF_8));
        buff.put(String.valueOf(timeStamp).concat("\n").getBytes(StandardCharsets.UTF_8));

        if(this.hasData) {
            buff.putShort(dataSize);
            buff.put(data);
        }

        return buff.array();
    }

    public static OVRPacket deserialize(byte[] packetData) throws IllegalArgumentException{
        ByteBuffer buff = ByteBuffer.wrap(packetData);
        OVRPacket res = new OVRPacket();

        res.headerSize = buff.getShort();
        if (buff.getChar() == 'Y') res.hasData = true;
        else res.hasData = false;

        byte[] headerBuff = new byte[res.headerSize];
        buff.get(headerBuff,0,res.headerSize);
        String[] packetArgs = StandardCharsets.UTF_8.decode(ByteBuffer.wrap(headerBuff)).toString().split("\n");
        res.cmd = OVRCmd.valueOf(packetArgs[0]);
        res.srcNode = packetArgs[1];
        res.destNode = packetArgs[2];
        res.serverName = packetArgs[3];
        res.seq = Short.parseShort(packetArgs[4]);
        res.timeStamp = LocalDateTime.parse(packetArgs[5]);

        if (res.hasData){
            res.dataSize = buff.getShort();
            byte[] dataBuff = new byte[res.dataSize];
            buff.get(dataBuff,0,res.dataSize);
            res.data = dataBuff;
        }

        return res;
    }

    public String toString() {
        final StringBuffer sb = new StringBuffer("");
        sb.append("[").append(cmd.toString()).append("]");
        sb.append(" Src:'").append(this.srcNode).append("'");
        sb.append(" Dest:'").append(this.destNode).append("'");
        sb.append(" Server:'").append(this.serverName).append("'");
        sb.append(" Seq:").append(this.seq);
        sb.append(" TimeStamp:").append(this.timeStamp);

        if(this.hasData) sb.append(" DataSize:").append(this.dataSize);

        return sb.toString();
    }

    public OVRCmd getCmd() {
        return cmd;
    }

    public String getSrcNode() {
        return srcNode;
    }

    public String getDestNode() {
        return destNode;
    }

    public String getServerName() {
        return serverName;
    }

    public byte[] getData() {
        return data;
    }

    public short getSeq() {
        return seq;
    }

    public LocalDateTime getTimeStamp() {
        return timeStamp;
    }

    public long getPacketSize(){
        return this.headerSize + this.dataSize;
    }
}
