package Lab02;


import java.applet.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;


// Attempt at a simple handshake.  Girl pings Boy, gets confirmation.
// Then Boy pings girl, get confirmation.
class Monitor {
    String name;
    boolean isPinging = false;
//    public boolean getIsPinging() { return this.isPinging; }

    public Monitor(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    // Girl thread invokes ping, asks Boy to confirm.  But Boy invokes ping,
    // and asks Girl to confirm.  Neither Boy nor Girl can give time to their
    // confirm call because they are stuck in ping.  Hence the handshake
    // cannot be completed.
    public synchronized void ping(Monitor p) {
        System.out.println(this.name + " (ping): pinging " + p.getName());
        this.isPinging = true;

        p.release(this); // let the other thread know we are going to wait and let it run

        try {
            System.out.println(this.name + " waiting... ");
            this.wait(); // sleep this thread and wait for other thread to release us so we can continue
        } catch (Exception e) {
            System.out.println(this.name + " FAILED to wait");
        }

        System.out.println(this.name + " done waiting");

        // tell other thread we have gotten their ping, which will allow them to confirm their ping to us was successful
        p.confirm(this);

        System.out.println(this.name + " (ping): got CONFIRMATION");

        p.release(this); // let the other thread know we are done and it can start back up
    }

    public synchronized void confirm(Monitor p) {
        System.out.println("  " + this.name + " (confirm): confirm to " + p.getName());
        p.isPinging = false;
    }

    public synchronized void release(Monitor p) {
        System.out.println("  " + p.getName() + " releasing " + this.getName());
        try {
            if (this.isPinging) {
                this.notify();
                System.out.println("  " + this.getName() + " released");
            } else {
                System.out.println("  " + this.getName() + " doesn't need to be released");
            }
        } catch (Exception e) {
            System.out.println("  " + this.name + " FAILED to release " + " | " + e.toString());
        }
    }
}

class Runner extends Thread {
    Monitor m1, m2;

    public Runner(Monitor m1, Monitor m2) {
        this.m1 = m1;
        this.m2 = m2;
    }

    public void run() {
        m1.ping(m2);
    }
}

public class DeadLock {
    public static void main(String args[]) {
        int i = 1;
//        while(i < 15)
        {
//            try { Thread.sleep(2000); }
//            catch (InterruptedException e) { e.printStackTrace(); }
            System.out.println("\nStarting..." + (i++));
            Monitor a = new Monitor("Girl");
            Monitor b = new Monitor("Boy ");
            (new Runner(a, b)).start();
            (new Runner(b, a)).start();
        }
    }
}
