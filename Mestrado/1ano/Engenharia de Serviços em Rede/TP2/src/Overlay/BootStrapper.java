import java.io.FileReader;
import java.io.IOException;
import java.net.InetAddress;
import java.util.*;

import org.json.simple.*;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class BootStrapper implements Runnable{

    private OVRTransmitter transmitter;
    private Map<String, JSONArray> vizinhos = new HashMap<>();
    private Map<String,String> ipToSend = new HashMap<>();
    private int topologia;
    private int myPort;
    private static String myMachineName;

    static {
        try {
            myMachineName = InetAddress.getLocalHost().getHostName();
        } catch (Exception e) {
            String[] errorList = e.toString().split(":");
            myMachineName = errorList[1].strip();
        }
    }

    public BootStrapper(int bootStrapperPort,int topologia){
        this.topologia = topologia;
        this.myPort = bootStrapperPort;
    }

    public void run() {

        Logger.logCustomMessage("BOOTSTAPPER: Starting",false);

        try{
            transmitter = new OVRTransmitter(myPort,"BootStrapper");
            readConfiguration(true,3);
            readConfiguration(false,3);
        } catch (Exception e){
            Logger.logCustomMessage("BOOTSTRAPPER ERROR: "+e.toString(),true);
            return;
        }

        while(true){

            try{
                OVRPacket nodePacket = transmitter.receivePacket(true,0);
                String nameReceived = transmitter.getDestNodeName();

                if (nodePacket.getCmd().equals(OVRPacket.OVRCmd.INITREQUEST) && this.vizinhos.containsKey(nameReceived)){
                    transmitter.sendJSON(this.dataToOverlayJson(nameReceived));
                }
                else{
                    Logger.logCustomMessage("BOOTSTRAPPER WARN: Received Unhandled Command '"+nodePacket.getCmd()+"' or Unknown Machine '"+nameReceived+"'",true);
                }

            } catch (IOException| IllegalArgumentException e){
                Logger.logCustomMessage("BOOTSTRAPPER WARN: "+e.toString(),true);
            }
        }

    }

    public void readConfiguration(boolean vizinhos, int topologia) throws IOException,ParseException {
        JSONParser jsonParser = new JSONParser();
        FileReader reader;
        if (vizinhos) {
            reader = new FileReader("./topologias/top" + topologia + "-Vizinhos.JSON");

            JSONObject obj = (JSONObject) jsonParser.parse(reader);
            obj.forEach((k, v) -> {
                JSONArray readJsonList = (JSONArray) v;
                this.vizinhos.put(k.toString(), readJsonList);

            });
        }
        else {
            reader = new FileReader("./topologias/top" + topologia + "-Ips.JSON");

            JSONObject obj = (JSONObject) jsonParser.parse(reader);
            obj.forEach((k, v) -> {
                this.ipToSend.put(k.toString(),v.toString());
            });

        }

    }

    public JSONObject dataToOverlayJson(String idRouter) {

        //Recolhe os Ips a enviar
        JSONObject resObj = new JSONObject();
        for(Object vizinhoName : vizinhos.get(idRouter)){
            for (Map.Entry<String,String> ipsEntry : ipToSend.entrySet()){
                if (vizinhoName.toString().equals(ipsEntry.getKey())){
                    resObj.put(ipsEntry.getKey(),ipsEntry.getValue());
                }
            }
        }

        return resObj;
    }

}
