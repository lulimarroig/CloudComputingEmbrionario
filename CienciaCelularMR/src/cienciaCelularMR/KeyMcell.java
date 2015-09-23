/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cienciaCelularMR;


import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.util.Objects;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.WritableComparable;

/**
 *
 * @author camila
 */
public class KeyMcell implements WritableComparable {

    // Some data

    private final Text idUsuario = new Text();
    private final Text subIdUsuario = new Text();
    private final Text modoFernet = new Text();

    public void setIdUsuario(Text value) {
        idUsuario.set(value);
    }
    
    public void setSubIdUsuario(Text value) {
        subIdUsuario.set(value);
    }

    public void setModoFernet(Text _modoFernet) {
        modoFernet.set(_modoFernet);
    }

    public Text getIdUsuario() {
        return idUsuario;
    }

    public Text getModoFernet() {
        return modoFernet;
    }

    public Text getSubIdUsuario() {
        return subIdUsuario;
    }
    
    @Override
    public void write(DataOutput out) throws IOException {
        System.out.println("WRITE KEY modoFernet - " + modoFernet.toString());
        System.out.println("WRITE KEY idUsuario - " + idUsuario.toString());
        modoFernet.write(out);
        idUsuario.write(out);
        subIdUsuario.write(out);
    }

    @Override
    public void readFields(DataInput in) throws IOException {
        modoFernet.readFields(in);
        idUsuario.readFields(in);
        subIdUsuario.readFields(in);
    }

    @Override
    public int compareTo(Object o) {
        KeyMcell sentiment = (KeyMcell) o;
        Text thisValue = this.idUsuario;
        Text thatValue = sentiment.idUsuario;

        return this.equals(o) ? 0 : (thatValue.compareTo(thisValue) == 0 ? -1 : 1);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + idUsuario.hashCode();
        //result = prime * result + (int) (timestamp ^ (timestamp >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final KeyMcell other = (KeyMcell) obj;
        return Objects.equals(this.modoFernet, other.modoFernet)
                && Objects.equals(this.idUsuario, other.idUsuario);
    }

    @Override
    public String toString() {
        return modoFernet.toString() + "-" + idUsuario.toString() + "." + subIdUsuario.toString();//To change body of generated methods, choose Tools | Templates.
    }    
}
