/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;

/**
 *
 * @author camila
 */
public class FernetOutput implements Writable {

    private final Text fileName = new Text();
    private final BytesWritable value = new BytesWritable();
    private final Text subId = new Text();
    //private final Text fileOutputName = new Text();

    public Text getFileName() {
        return fileName;
    }

    public void setFileName(Text fileName) {
        this.fileName.set(fileName);
    }

//    public Text getFileOutputName() {
//        return fileOutputName;
//    }
//    
//     public void setFileOutputName(Text fileName) {
//        this.fileOutputName.set(fileName);
//    }    

    public BytesWritable getValue() {
        return value;
    }

    public void setValue(BytesWritable value) {
        this.value.set(value);
    }

    public Text getSubId() {
        return subId;
    }

    public void setSubId(Text subId) {
        this.subId.set(subId);
    }
    
    @Override
    public void write(DataOutput d) throws IOException {
       fileName.write(d);
       subId.write(d);
       value.write(d);
       //fileOutputName.write(d);
    }

    @Override
    public void readFields(DataInput di) throws IOException {
        fileName.readFields(di);
        subId.readFields(di);
        value.readFields(di);
        //fileOutputName.readFields(di);
    }

}
