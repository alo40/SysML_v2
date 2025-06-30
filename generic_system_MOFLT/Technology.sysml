package Technology {
    public import Definitions::Technology::*;
    public import Operations::Context::*;
    package PartsTree {
        part system {
            part upperCover;
            part lowerCover;
            part housing;
            part mechButton;
            part fixationParts {
                part screw[*];
                part nut[*];
            }
            part pcba {
                part adqCircuit {
                    part microswitch;
                    part resistor[*];
                    part capacitor[*];
                }
                part mcu : Microcontroller ;
                part powerRegulator : PowerRegulator;
                part transceiver : Transceiver;
                part mainConnector : MainConnector;
                part jtag;
            }
        }
        part harness {
            part wire;
            part mainConnector : MainConnector;
            part vehicleConnector;
        }
    }
    package Interfaces {
        package External {
            // Power
            interface Actors::vehicle.p_extPower 
                to PartsTree::harness.mainConnector.p_extPower;
            interface PartsTree::harness.mainConnector.p_extPower 
                to PartsTree::system.pcba.mainConnector.p_extPower;
            // Communication
            interface Actors::vehicle.p_extComm 
                to PartsTree::harness.mainConnector.p_extComm;
            interface PartsTree::harness.mainConnector.p_extComm 
                to PartsTree::system.pcba.mainConnector.p_extComm;
        }
        package Internal {
            // Power
            interface PartsTree::system.pcba.mainConnector.p_extPower
                to PartsTree::system.pcba.powerRegulator.p_extPower;
            interface PartsTree::system.pcba.powerRegulator.p_intPower
                to PartsTree::system.pcba.mcu.p_intPower;
            // Communication
            interface PartsTree::system.pcba.mainConnector.p_extComm
                to PartsTree::system.pcba.transceiver.p_extComm;
            interface PartsTree::system.pcba.transceiver.p_intComm
                to PartsTree::system.pcba.mcu.p_intComm;
        }
    }
}