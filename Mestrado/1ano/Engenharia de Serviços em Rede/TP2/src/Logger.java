import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Logger {

    private static String fileName = "./logs/";
    private static String userName;
    private static FileWriter file;

    public static String machineName;

    static {
        try {
            Files.createDirectories(Paths.get(fileName));
            machineName = InetAddress.getLocalHost().getHostName();
            userName = System.getProperty("user.name")+"@"+machineName;
            fileName += userName+"-Log.txt";
            file = new FileWriter(fileName,false);
        } catch (Exception e) {
            String[] errorList = e.toString().split(":");
            machineName = errorList[1].strip();
            userName = System.getProperty("user.name")+"@"+machineName;
            fileName += userName+"-Log.txt";
            try {
                file = new FileWriter(fileName,false);
            } catch (IOException ex) {
                System.out.println("Error Creating Log:"+ex.toString());
                System.exit(1);
            }
        }
    }
    private static PrintWriter print = new PrintWriter(file);

    private static void printToLog(String msg){
        print.println("["+LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss.nnnnnn"))+"] - "+msg);
        print.flush();
    }

    public static void logCustomMessage(String msg,boolean printToConsole){
        printToLog("MESSAGE: "+msg);
        if (printToConsole)
            System.out.println(userName+": "+msg);
    }

    public static void logWarning(String warning){
        printToLog("WARNING: "+warning);
    }

    public static void logError(String error){
        printToLog("ERROR: "+error);
    }

    public static void logOVRPacket(OVRPacket packet, boolean sent){
        if(sent)
            printToLog("SENT: "+packet.toString());
        else
            printToLog(" GOT: "+packet.toString());
    }

    public static void closeLogger() throws IOException{
        file.close();
    }

}
