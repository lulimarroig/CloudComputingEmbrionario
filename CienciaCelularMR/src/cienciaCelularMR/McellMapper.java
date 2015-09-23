/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;

/**
 *
 * @author camila
 */
public class McellMapper extends Mapper<KeyMcell, BytesWritable, KeyMcell, Text> {

    private MultipleOutputs mos;
    public Pattern pattern = Pattern.compile(".*Iterations: ([0-9]+) of ([0-9]+).*",
            Pattern.CASE_INSENSITIVE | Pattern.DOTALL);

    @Override
    public void setup(Context context) throws IOException, InterruptedException {
        mos = new MultipleOutputs(context);
    }

    @Override
    public void map(KeyMcell key, BytesWritable value, Context output) throws IOException, InterruptedException {
        try {
            System.out.println("Entro al Map");
            System.out.println("Key del mcell mapper: " + key);            

            byte[] arrayByte = value.copyBytes();
            File archivo = new File("entradaMap.mdl");
            try (FileOutputStream fos = new FileOutputStream(archivo)) {
                fos.write(arrayByte);
                fos.flush();
            }

            Process process = new ProcessBuilder("mcell.exe", "-errfile", "errorMcell.txt", "entradaMap.mdl").start();

            InputStream is = process.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line;
            Matcher matcher;

            System.out.println("Mcell is running");
            String res = "";
            while ((line = br.readLine()) != null) {
                res = res.concat(line);
                res = res.concat("\n");
                output.progress();
                try {
                    matcher = pattern.matcher(line);
                    if (matcher.find()) {
                        int fieldCount;
                        Text[] fields;

                        fieldCount = matcher.groupCount();
                        fields = new Text[fieldCount];
                        for (int i = 0; i < fieldCount; i++) {
                            fields[i] = new Text(matcher.group(i + 1));
                        }
                        System.out.println("Progreso: " + Integer.parseInt(fields[0].toString()) + " de " + Integer.parseInt(fields[1].toString()));
                    }
                } catch (Exception ex) {
                }
            }

            File errorFile = new File("errorMcell.txt");
            if (errorFile.exists()) {
                InputStream in = new FileInputStream(errorFile);
                BufferedReader reader = new BufferedReader(new InputStreamReader(in));
                String l;
                while ((l = reader.readLine()) != null) {
                    res = res.concat(l);
                    res = res.concat("\n");
                }
            }

            mos.write("controloutput", key, new Text(res));

            //free memory
            res = "";
            System.out.println("Leyendo salida de MCell...");

            String salidaName = "salidaMCell-" + key.getIdUsuario() + "." + key.getSubIdUsuario() + ".dat";
            FSDataOutputStream fs = FileSystem.get(output.getConfiguration()).create(new Path(salidaName));

            File salidaFile = new File("joined_1.dat");            

            if (salidaFile.exists()) {
                FileInputStream ios = new FileInputStream(salidaFile);
                byte[] buf = new byte[1024];
                int totalbytes = 0;
                int bytesRead;
                while ((bytesRead = ios.read(buf)) > 0) {
                    totalbytes+=bytesRead;
                    fs.write(buf, 0, bytesRead);
                    fs.flush();
                    output.progress();
                }
                fs.close();
                ios.close();
                
                System.out.println("***Mcell termino de leer y guardar archivo .dat, tamaño: "+totalbytes);
                System.out.println("Nombre que se le pasa a Fernet: " + salidaName);
                output.write(key, new Text(salidaName));
            } else {
                errorFile = new File("errorMcell.txt");
                if (errorFile.exists()) {
                    InputStream in = new FileInputStream(errorFile);
                    BufferedReader reader = new BufferedReader(new InputStreamReader(in));
                    String l;
                    while ((l = reader.readLine()) != null) {
                        res = res.concat(l);
                        res = res.concat("\n");
                    }
                    if (!"".equals(res)) {
                        mos.write("errormcell", key, new Text(res));
                    }
                }
            }
        } catch (IOException | IllegalArgumentException | InterruptedException ex) {        
            String salidaName = "errorMapper-" + key.getIdUsuario() + "." + key.getSubIdUsuario() + ".txt";
            FSDataOutputStream fs = FileSystem.get(output.getConfiguration()).create(new Path(salidaName));
            fs.write(new Byte("Error en Mapper MCell:"));
            fs.write(new Byte("\n"));
            fs.flush();
            fs.close();           

            Logger.getLogger(McellMapper.class.getName()).log(Level.SEVERE, null, ex);
            throw new InterruptedException(ex.getMessage());
        }
    }

    @Override
    public void cleanup(Context c) throws IOException {
        try {
            mos.close();
        } catch (InterruptedException ex) {
            Logger.getLogger(McellMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
