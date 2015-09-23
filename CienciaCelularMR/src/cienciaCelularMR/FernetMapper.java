/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.IOException;
import static org.apache.commons.io.FileUtils.readFileToByteArray;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

/**
 *
 * @author Lu
 */
public class FernetMapper extends Mapper<KeyMcell, Text, KeyMcell, FernetOutput> {

    @Override
    public void map(KeyMcell key, Text value, Context output) throws IOException, InterruptedException {
        try {

            System.out.println("Entro al Map");
            System.out.println("Key del map fernet: " + key.toString());

            System.out.println("Fernet empezo a leer y guardar archivo .dat");
            try (FSDataInputStream fis = FileSystem.get(output.getConfiguration()).open(new Path(value.toString()))) {
                File archivo = new File("entradaFernet.dat");
                try (FileOutputStream fos = new FileOutputStream(archivo)) {
                    byte[] buf = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = fis.read(buf)) > 0) {
                        fos.write(buf, 0, bytesRead);
                        fos.flush();
                        output.progress();
                    }
                    fos.close();
                    fis.close();
                }
            }

            System.out.println("Fernet termino de leer y guardar archivo .dat");
            Process process = new ProcessBuilder("fernet.exe",
                    "--mode=" + key.getModoFernet().toString(), "--config=fernet.cfg",
                    "entradaFernet.dat").start();

            InputStream is = process.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line;

            System.out.println("Fernet is running");
            System.out.println("La key de mapper fernet es: " + key);
            String res = "";
            while ((line = br.readLine()) != null) {
                res = res.concat(line);
                output.progress();                     
            }

            if ("point".equals(key.getModoFernet().toString())) {
                System.out.println("Fernet es point");
                String salidaName = "salidaFernet-" + key.getIdUsuario() + "." + key.getSubIdUsuario() + ".txt";
                FSDataOutputStream fs = FileSystem.get(output.getConfiguration()).create(new Path(salidaName));

                File salidaFile = new File("out_point.txt");
                if (salidaFile.exists()) {

                    byte[] buffer = readFileToByteArray(new File("out_point.txt"));
                    FernetOutput salida = new FernetOutput();
                    salida.setFileName(new Text("out_point.txt"));
                    salida.setSubId(key.getIdUsuario());
                    salida.setValue(new BytesWritable(buffer));
                    output.write(key, salida);
                }
            } else {
                File dir = new File(".");
                FileFilter fileFilter = new WildcardFileFilter("multi_*.txt");
                File[] files = dir.listFiles(fileFilter);
                for (File file : files) {
                    byte[] buffer = readFileToByteArray(new File(file.getName()));
                    FernetOutput salida = new FernetOutput();
                    salida.setFileName(new Text(file.getName()));
                    salida.setSubId(key.getIdUsuario());
                    salida.setValue(new BytesWritable(buffer));
                    output.write(key, salida);
                }
            }
                   
        } catch (Exception ex) {            
            String salidaName = "errorMapper-" + key.getIdUsuario() + "." + key.getSubIdUsuario() + ".txt";
            FSDataOutputStream fs = FileSystem.get(output.getConfiguration()).create(new Path(salidaName));
            fs.write(new Byte("Error en Mapper FERnet"));
            fs.write(new Byte("\n"));
            fs.flush();
            fs.close();
            
            Logger.getLogger(FernetMapper.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

}
