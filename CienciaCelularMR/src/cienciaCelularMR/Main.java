/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;

import java.util.zip.ZipOutputStream;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.SequenceFileInputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.chain.ChainMapper;
import org.apache.hadoop.mapreduce.lib.chain.ChainReducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.LazyOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

/**
 *
 * @author Lu
 */
public class Main extends Configured implements Tool {

    public static void main(String[] args) throws Exception {
        int res = ToolRunner.run(new Main(), args);
        System.exit(res);
    }

    @Override
    public int run(String[] args) throws Exception {

        for (int i = 0; i < args.length; i++) {
            System.out.println("Hadoop - arg[" + i + "] es: " + args[i]);
        }
        //Configuración de memoria de YARN
        Configuration conf = new Configuration();
        conf.set("mapreduce.map.memory.mb", "1400");
        conf.set("mapreduce.reduce.memory.mb", "2800");
        conf.set("mapreduce.map.java.opts", "-Xmx1120m");
        conf.set("mapreduce.reduce.java.opts", "-Xmx2240m");
        conf.set("yarn.app.mapreduce.am.resource.mb", "2800");
        conf.set("yarn.app.mapreduce.am.command-opts", "-Xmx2240m");
        conf.set("yarn.nodemanager.resource.memory-mb", "5040");
        conf.set("yarn.scheduler.minimum-allocation-mb", "1400");
        conf.set("yarn.scheduler.maximum-allocation-mb", "5040");
        conf.set("mapreduce.task.timeout", "18000000");//5 horas
        
        //Creación del Job
        Job job = Job.getInstance(conf);
        job.setInputFormatClass(WholeFileInputFormat.class);
        FileInputFormat.setInputPaths(job, new Path(args[5]));
        FileOutputFormat.setOutputPath(job, new Path(args[6]));       
        
        //Salidas alternativas de Mapper para brindar información
        MultipleOutputs.addNamedOutput(job, "controloutput", TextOutputFormat.class, KeyMcell.class, Text.class);
        MultipleOutputs.addNamedOutput(job, "errormcell", TextOutputFormat.class, KeyMcell.class, Text.class);
        
        //Archivos copiados a cache de los nodos
        job.addCacheFile(new Path("wasb:///mcell.exe").toUri());
        job.addCacheFile(new Path("wasb:///fernet.exe").toUri());
        job.addCacheFile(new Path("wasb:///fernet.cfg").toUri());
        job.addCacheFile(new Path("wasb:///libconfig_d.dll").toUri());
        job.addCacheFile(new Path("wasb:///libtiff3.dll").toUri());
        job.addCacheFile(new Path("wasb:///jpeg62.dll").toUri());
        job.addCacheFile(new Path("wasb:///zlib1.dll").toUri());
        job.addCacheFile(new Path("wasb:///msvcr100d.dll").toUri());

        job.setJarByClass(Main.class);

        Configuration mapAConf = new Configuration(false);
        ChainMapper.addMapper(job, McellMapper.class, KeyMcell.class, BytesWritable.class,
                KeyMcell.class, Text.class, mapAConf);
        
        Configuration mapBConf = new Configuration(false);
        ChainMapper.addMapper(job, FernetMapper.class, KeyMcell.class, Text.class,
                KeyMcell.class, FernetOutput.class, mapBConf);
        
        job.setReducerClass(ResultReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(BytesWritable.class);
           
        job.submit();
        return 0;
    }
}
