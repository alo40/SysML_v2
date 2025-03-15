package Batmobile_Architecture {    
    package Stage_1_Capability {
        /* comment
        What the system does in the context

        Scope:
        capability concept definition */
    }
    comment about Stage_1_Capability /* comment not in scope */ 
    package Stage_2_Operational {
        /* comment
        How the system is going to be used?
        
        Scope:
        operational use cases
        operational scenarios
        operational mission */
    }
    package Stage_3_Logical {
        /* comment
        What the system does?

        Scope:
        functional decomposition
        functional interfaces
        functional flows (energy, heat, matter, etc.)
        behaviours */
    }
    package Stage_4_Physical {
        /*  comment
        How the system does it?
            
        Scope:
        physical breakdown
        physical interfaces (connectors)
        physical flows
        physical constrains
        mapping to logical stage */

        package Definitions {
            part def Vehicle {
                item driver;
                part engine;
                attribute actualSpeed : SI::SpeedUnit;
            }
            part def Batmobile specializes Vehicle {
                part batmobileEngine redefines engine {
                    port enginePort : ~PowerIP;
                } 
                part seat[2];
                part body;
                part wheels[4] : Wheel;
                part frontLeftWheel subsets wheels;
                part frontRightWheel subsets wheels;
                part battery {
                    port powerPort : PowerIP;
                    attribute capacity;
                }
                interface battery2engine : PowerInterface connect 
                    battery.powerPort to batmobileEngine.enginePort;
            }
            part def BatmobileNG specializes Batmobile {
                part bulletProofWheels[4] redefines wheels;
            }
            part def Wheel {
                attribute pressure;
            }
            port def PowerIP {
                out item power : Power;
            }
            item def Power {
                attribute value;
            }
            interface def PowerInterface {
                end supplierPort : PowerIP;
                end consumerPort : ~PowerIP;
                flow of Power from supplierPort.power to consumerPort.power;
            }
        }
        package Physical_Breakdown {
            
        }   
    }
}