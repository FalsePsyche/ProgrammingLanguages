package Lab02;


import java.applet.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;



// Attempt at a simple handshake.  Girl pings Boy, gets confirmation.
// Then Boy pings girl, get confirmation.
class Monitor {
    String name;

    public Monitor (String name) { this.name = name; }

    public String getName() {  return this.name; }

    public static void print(String words)
    {
        System.out.println(System.nanoTime() + " | " + words);
    }


    // Girl thread invokes ping, asks Boy to confirm.  But Boy invokes ping,
    // and asks Girl to confirm.  Neither Boy nor Girl can give time to their
    // confirm call because they are stuck in ping.  Hence the handshake
    // cannot be completed.
    public synchronized void ping (Monitor p)
    {
        print(this.name + " (ping): pinging " + p.getName());
//        System.out.println(this.name + " (ping): pinging " + p.getName());

        p.release(this);

        try {

            print(this.name + " waiting... ");
//            System.out.println(this.name + " waiting... ");
            this.wait(500);
        }
        catch (InterruptedException e) {print(this.name + " InterruptException");}

        p.confirm(this);
        print(this.name + " (ping): got confirmation");
    }

    public synchronized void confirm (Monitor p)
    {
        print(this.name + " (confirm): confirm to " + p.getName());
//        System.out.println(this.name + " (confirm): confirm to " + p.getName());
    }

    public synchronized void release (Monitor p)
    {
        print(this.name + " has entered release");
//        System.out.println(this.name + " has entered release");
//        try
//        {
        print(this.name + " notifying " + p.getName());
//            System.out.println(this.name + " notifying " + p.getName());
            p.notify();

//            this.wait(500);
//            System.out.println(this.name + " waiting... ");
//        }
//        catch (InterruptedException e)
//        {
            /*e.printStackTrace(); */
//            System.out.println(this.name + " InterruptException" + e.getMessage());
//        }
    }
}

class Runner extends Thread {
    Monitor m1, m2;

    public Runner (Monitor m1, Monitor m2) {
        this.m1 = m1;
        this.m2 = m2;
    }

    public void run () {  m1.ping(m2);  }
}

public class DeadLock {
    public static void main (String args[]) {
        int i=1;
        System.out.println("Starting..."+(i++));
        Monitor a = new Monitor("Girl");
        Monitor b = new Monitor("Boy");
        (new Runner(a, b)).start();
        (new Runner(b, a)).start();
    }
}
