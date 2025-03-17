package Definitions {
            item def Hero;
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
                item boundingBox : ShapeItems::Box[1] subsets boundingShapes {
                    redefines length : ISQ::LengthUnit = 80 [SI::cm];
                    redefines width : ISQ::LengthUnit = 26 [SI::cm];
                    redefines height : ISQ::LengthUnit = 80 [SI::cm];
                }
            }
            part def Engine {
                perform action rocketBoost {
                    in cmd : EngineCommand = engineControl.cmd;
                }
                port engineControl {
                    in item cmd : EngineCommand;
                }
            }
            item def EngineCommand;
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
            enum def StatusKind {
                enum safe;
                enum alert;
            }
        }