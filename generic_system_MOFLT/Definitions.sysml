package Definitions {
    public import ISQ::*;
    public import ScalarValues::*;
    public import Logical::*;
    package Technology {
        part def Microcontroller  {
            // Attributes
            attribute clockSpeed : Real; // MHz
            attribute flashMemory : Real; // KB
            attribute ram : Real; // KB
            // Ports
            port p_hmiSignal;
            port p_intComm;
            port p_extComm;
            port p_diagnostic;
            port p_intPower;
            port p_extPower;
            port p_ground;
            port p_jtag; // For debugging and programming
        }
        part def Transceiver {
            // Attributes
            attribute protocolBaudRate : Real; // kbit/s
            attribute protocolVersion : String; 
            attribute protocolNodeRole : String; // "Master" or "Slave"
            // Ports 
            port p_intComm;       
            port p_extComm; 
        }
        part def PowerRegulator {
            port p_extPower;
            port p_intPower;
        }
        part def MainConnector {
            port p_extPower;
            port p_extComm;
        }
    }
    package Operations {
        part def Vehicle {
            port p_extPower;
            port p_extComm;
        }
    }
}