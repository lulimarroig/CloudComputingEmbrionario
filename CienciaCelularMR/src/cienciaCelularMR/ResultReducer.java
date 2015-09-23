/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;


import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.logging.Logger;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

/**
 *
 * @author camila
 * @param <Key>
 */
public class ResultReducer<Key> extends Reducer<KeyMcell, FernetOutput, Text, BytesWritable> {

    protected ZipFileWriter zipFileWriter = null;
    private HashMap<String, ZipFileWriter> zips = new HashMap<>();
    static final Logger log = Logger.getLogger("log_file");
    Configuration conf = null;

    @Override
    @SuppressWarnings("unchecked")
    protected void setup(Context context)
            throws IOException, InterruptedException {
        conf = context.getConfiguration();
    }

    @Override
    public void reduce(KeyMcell key, Iterable<FernetOutput> values, Context context) {
        System.out.println("Entro al reducer!!");
        System.out.println("Key del reducer: " + key);
        FileSystem fs;
        try {

            zipFileWriter = zips.get(key.toString());
            if (zipFileWriter == null) {
                System.out.println("CREAR " + key.toString());
                zipFileWriter = new ZipFileWriter(key.getIdUsuario() + "." + key.getSubIdUsuario() + "-resultados");//set subjob id
                zipFileWriter.setup(conf);
                zipFileWriter.openZipForWriting();
                zips.put(key.toString(), zipFileWriter);
                System.out.println("Guarde Zip en map " + key.toString());
            } else {
                System.out.println("GET " + key.toString());
            }

            fs = FileSystem.get(context.getConfiguration());
            for (FernetOutput t : values) {
                System.out.println("Archivo de salida fernet es: " + t.getFileName().toString());
                zipFileWriter.addBinaryFile(t.getFileName().toString(), t.getValue().getBytes(), t.getValue().getLength());
            }

            zipFileWriter.getZipOutputStream().flush();
            zipFileWriter.closeZip();
            System.out.println("Cerre ZIP");

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void cleanup(Reducer.Context context)
            throws IOException, InterruptedException {
        Iterator<String> it = zips.keySet().iterator();
        while (it.hasNext()) {
            zips.get(it.next()).closeZip();
        }
    }
}
