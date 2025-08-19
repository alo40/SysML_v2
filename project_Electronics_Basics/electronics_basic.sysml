package electronics_basic {
    // private import SI::*;
    // private import ISQ::*;
    part circuit {
        part battery {
            port plus;
            port minus;
            attribute voltage = 5.0;
        }
        part resistor {
            port a;
            port b;
            attribute resistance = 1000.0;
            attribute current =  battery.voltage / resistance;
        }
        interface connect battery.plus to resistor.a;
        interface connect resistor.b to battery.minus;
    }
}