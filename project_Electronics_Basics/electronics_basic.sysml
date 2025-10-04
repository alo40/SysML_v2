package electronics_basic {
    private import SI::*;
    private import ISQ::*;
    part def Battery {
        port '+';
        port '-';
    }
    part def Resistor {
        port a;
        port b;
    }
    part circuit {
        part b1 : Battery {
            attribute voltage = 5.0;
            attribute current = voltage / (r1.resistance + r2.resistance);
        }
        part r1 : Resistor {
            attribute resistance = 100.0;
        }
        part r2 : Resistor {
            attribute resistance = 400.0;
        }
        interface connect b1.'+' to r1.a;
        interface connect r1.b to r2.a;
        interface connect r2.b to b1.'-';
    }
    requirement <R1> 'max allowed current' {
        subject b1;
        attribute currentMax = 0.02;
    }
    requirement <R2> 'min allowed current' {
        subject b1;
        attribute currentMin = 0.01;
    }
    requirement <R3> 'min alowed resistance for r1' {
        subject r1;
        attribute resistanceMin = 100;
    }
    requirement <R4> 'min alowed resistance for r2' {
        subject r2;
        attribute resistanceMin = 500;
    }
}
