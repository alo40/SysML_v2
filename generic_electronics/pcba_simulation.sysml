package Electronics {
    package Definitions {
        abstract part def Product;
        abstract part def Component {
            port a;
            port b;        
        }
        part def Resistor :> Component {
            attribute resistance :> ISQ::resistance;
        }
        part def CircuitBoard :> Component {
            power :>> a;
            ground :>> b;
        }
        part def Microswitch :> Component {
            attribute operatingForce :> ISQ::force;
            attribute operatingCycles : ScalarValues::Integer;
        }
        part def LED :> Component {
            attribute color : ScalarValues::String;
            cathode :>> a;
            anode :>> b;
        }
        part def Microcontroller :> Component {
            power :>> a;
            ground :>> b;
            port gpio_1;
            port gpio_2;
            port gpio_3;
            port gpio_4;
        }
    }
    package Components {
        private import Definitions::*;
        private import Functions::*;
        // functions
        perform activate_s1;
        perform activate_s2;
        perform turn_led1_on;
        perform turn_led1_off;
        perform turn_led2_on;
        perform turn_led2_off;
        // attributes
        // ports
        // parts
        part box : Product {
            part pcb : CircuitBoard {
                // attributes
                // ports
                // parts
                part r1 : Resistor;
                part r2 : Resistor;
                part s1 : Microswitch;
                part s2 : Microswitch;
                part led1 : LED;
                part led2 : LED;
                part mcu : Microcontroller;
                // power interfaces
                interface i01 connect mcu.power to box.pcb.ground;
                interface i02 connect mcu.ground to box.pcb.ground;
                // switch interfaces
                interface i03 connect mcu.gpio_1 to s1.a;
                interface i04 connect mcu.gpio_2 to s2.a;
                interface i05 connect s1.b to r1.a;
                interface i06 connect s2.b to r2.a;
                interface i07 connect r1.b to box.pcb.ground;
                interface i08 connect r2.b to box.pcb.ground;
                // led interfaces
                interface i09 connect mcu.gpio_3 to led1.anode;
                interface i10 connect led1.cathode to box.pcb.ground;
                interface i11 connect mcu.gpio_4 to led2.anode;
                interface i12 connect led2.cathode to box.pcb.ground;
            }
        }
    }
    package Functions {
        action activate_s1;
        action activate_s2;
        action turn_led1_on;
        action turn_led1_off;
        action turn_led2_on;
        action turn_led2_off;
    }
    package State_Machine {
        // states
        state compositeState1 {
            entry; 
            then state1;
            state state1;
            transition
                first state1
                accept Functions::activate_s1 
                if Components::box.pcb.s1.operatingForce == 10 
                do Functions::turn_led1_on then state2;
            state state2;
            then done;
        }
    }
}