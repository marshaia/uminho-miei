

import java.io.IOException;

public class OVRDataTooLargeException extends IOException {
    public OVRDataTooLargeException(){
        super();
    }
    public OVRDataTooLargeException(String msg){
        super(msg);
    }
}
