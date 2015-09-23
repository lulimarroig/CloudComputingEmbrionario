package cienciaCelularMR;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.InputSplit;
import org.apache.hadoop.mapreduce.RecordReader;
import org.apache.hadoop.mapreduce.TaskAttemptContext;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;

public class WholeFileRecordReader extends
        RecordReader<KeyMcell, BytesWritable> {

    private FileSplit split;
    private Configuration conf;

    private final BytesWritable currValue = new BytesWritable();
    private final KeyMcell key = new KeyMcell();
    private boolean fileProcessed = false;
    private String userId;
    private String modoFernet;
    private String subUserId;
    private TaskAttemptContext context;

    @Override
    public void initialize(InputSplit split, TaskAttemptContext context)
            throws IOException, InterruptedException {
        this.split = (FileSplit) split;
        this.conf = context.getConfiguration();
        this.context = context;

    }

    @Override
    public boolean nextKeyValue() throws IOException, InterruptedException {
        if (fileProcessed) {
            return false;
        }
                //System.out.println("Pido archivo y el path es: " + this.split.getPath());
        //parsear Scene.main.mdl-modoFernet-IdUsuario.IdJob
        String[] spliteado = this.split.getPath().getName().split("-");
        this.modoFernet = spliteado[1];
        this.userId = spliteado[2].split("\\.")[0];
        this.subUserId = spliteado[2].split("\\.")[1];

        this.key.setIdUsuario(new Text(userId));
        this.key.setSubIdUsuario(new Text(subUserId));
        this.key.setModoFernet(new Text(modoFernet));

        int fileLength = (int) split.getLength();
        byte[] result = new byte[fileLength];

        FileSystem fs = FileSystem.get(conf);
        FSDataInputStream in = null;
        try {
            in = fs.open(split.getPath());
            IOUtils.readFully(in, result, 0, fileLength);
            currValue.set(result, 0, fileLength);

        } finally {
            IOUtils.closeStream(in);
        }
        this.fileProcessed = true;
        return true;
    }

    @Override
    public KeyMcell getCurrentKey() throws IOException,
            InterruptedException {
        return this.key;
    }

    @Override
    public BytesWritable getCurrentValue() throws IOException,
            InterruptedException {
        return currValue;
    }

    @Override
    public float getProgress() throws IOException, InterruptedException {
        return context.getProgress();
    }

    @Override
    public void close() throws IOException {
        // nothing to close
    }
}
