package VehicleModel {
    public import ISQ::*;
    package Definitions {
        package PartDefinitions {
            abstract part def Physical {
                attribute mass default 1;
            }
            part def Vehicle :> Physical {
                attribute dryMass;
                attribute cargoMass;
                attribute position;
                attribute velocity;
                attribute acceleration;
                attribute electricalPower;
                attribute Tmax;
                attribute maintenanceTime;
                attribute brakePedalDepressed;
                port fuelCmdPort;
                port vehicleToRoadPort;
                perform action providePower;
                perform action performSelfTest;
                perform action applyParkingBrake;
                perform action senseTemperature;
                exhibit state vehicleStates;
            }
            part def Engine :> Physical;
            part def Cylinder :> Physical;
            part def Transmission :> Physical;
            part def Driveshaft :> Physical;
            part def AxleAssembly :> Physical;
            part def Axle :> Physical;
            part def FrontAxle :> Axle {
                attribute steeringAngle;
            }
            part def HalfAxle :> Axle;
            part def Differential :> Physical;
            part def Wheel :> Physical {
                attribute diameter;
            }
            abstract part def Software;
            part def VehicleSoftware :> Software;
            part def VehicleController :> Software;
            part def FuelTank :> Physical {
                attribute fuelMassMax;
            }
            part def Road {
                attribute incline;
                attribute friction;
            }
            part def VehicleRoadContext {
                attribute time;
            }
            // Used for Specifying Context for Individuals
            part def SpatialTemporalReference;
            // Used for Defining Variants for Superset Model
            part def Engine4Cyl;
            part def Engine6Cyl;
            part def TransmissionChoices;
            part def TransmissionAutomatic;
            part def TransmissionManual;
            part def Sunroof;
        }
        package PortDefinitions;
        package ItemDefinitions;
        package SignalDefinitions;
        package InterfaceDefinitions;
        package ActionDefinitions;
        package StateDefinitions;
        package RequirementDefinitions;
        package AttributeDefinitions;
        package IndividualDefinitions;
    }
    package VehicleConfigurations {
        private import Definitions::PartDefinitions::*;
        package VehicleConfiguration_a {
            package PartsTree {
                part vehicle_a : Vehicle {
                    attribute mass :>> mass = fuelTank.mass + frontAxleAssembly.mass + rearAxleAssembly.mass;
                    part fuelTank : FuelTank {
                        attribute :>> mass = 1;
                    }
                    part frontAxleAssembly : AxleAssembly {
                        attribute :>> mass = frontAxle.mass + frontWheels.mass;
                        part frontAxle : Axle {
                            attribute :>> mass = 1;
                        }
                        part frontWheels : Wheel {
                            attribute :>> mass = 1;
                        }
                    }
                    part rearAxleAssembly : AxleAssembly {
                        attribute :>> mass = rearAxle.mass + rearWheels.mass;
                        part rearAxle : Axle {
                            attribute :>> mass = 1;
                        }
                        part rearWheels : Wheel {
                            attribute :>> mass = 1;
                        }
                    }
                }
            }
            package ActionTree;
            package States;
            package Requirements;
        }
        package VehicleConfiguration_b {
            package PartsTree {
                part vehicle_b : Vehicle {
                    part fuelTank : FuelTank;
                    part frontAxleAssembly : AxleAssembly {
                        part frontAxle : Axle;
                        part frontWheels : Wheel;
                    }
                    part rearAxleAssembly : AxleAssembly {
                        part rearWheel1 : Wheel;
                        part rearWheel2 : Wheel;
                        part differential;
                        part rearAxle : Axle {
                            part leftHalfAxle;
                            part rightHalfAxle;
                        }
                    }
                    part engine : Engine {
                        part cylinders;
                    }
                    part transmission : Transmission;
                    part driveshaft : Driveshaft;
                    part vehicleSoftware {
                        part vehicleController;
                    }
                }
            }
            package ActionTree {
                action providePower {
                    action generateTorque;
                    action amplifyTorque;
                    action transferTorque;
                    action distributeTorque;
                }
                action performSelfTest;
                action applyParkingBrake;
                action senseTemperature;
            }
            package States;
            package Requirements;   
        }
    }
    package VehicleAnalysis;
    package FuelEconomyAnalysisModel;
    package ElectricalPowerAnalysis;
    package ReliabilityAnalyis;
}