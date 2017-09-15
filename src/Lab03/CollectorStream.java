// Tanner Bornemann
// 15 Sep 2017
// Lab03 Collector Stream
// CS4003 Programming Languages

package Lab03;

import java.util.Vector;

public class CollectorStream extends Stream
{
    Notifier notifier;
    TCFrame f;
    Vector producers;

    public CollectorStream(Notifier notifier, TCFrame f)
    {
        // do the things
        this.producers = new Vector<Producer>();
        this.notifier = notifier;
        this.f = f;
    }

    public void add(Producer producer)
    {
        producers.add(producer);
    }

    public void run ()
    {
        double t = 0;
        for (int i = 0; i < this.producers.size(); i++)
        {
            Object producer = producers.get(i);
            Subscriber sub = (Subscriber) ((Producer)producer).next();
            t += sub.stock_value;
        }
        IntObject total = new IntObject((int)t);
        this.notifier.putValue(total);
        this.putIt(this.notifier);
    }
}
