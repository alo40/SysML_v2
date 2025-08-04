package VehicleModel {
    public import ISQ::*;
    package Definitions {
        package PartDefinitions {
            package VehicleTotalMass {
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
				part def Engine :> Physical {
					port mechanicalOutput;
					port fuelInput;
					port controlInput;
				}
                part def Cylinder :> Physical;
				part def Transmission :> Physical {
					port mechanicalInput;
					port mechanicalOutput;
					port controlInput;
				}
				part def Driveshaft :> Physical {
					port mechanicalInput;
					port mechanicalOutput;
				}
				part def AxleAssembly :> Physical {
					port mechanicalInput;
				}
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
				part def VehicleController :> Software {
					port engineControl;
					port transmissionControl;
					port infotainmentControl;
					port climateControl;
				}
                part def FuelTank :> Physical {
                    attribute fuelMassMax;
					port fuelOutput;
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
				part def InfotainmentSystem :> Physical {
					port controlInput;
				}
				part def ClimateControlSystem :> Physical {
					port controlInput;
				}
            }
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
        package VehicleConfiguration_a {
            private import Definitions::PartDefinitions::VehicleTotalMass::*;
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
            private import Definitions::PartDefinitions::VehicleTotalMass::*;
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
        package VehicleConfiguration_c {
            private import Definitions::PartDefinitions::VehicleTotalMass::*;
			private import Definitions::PartDefinitions::VehicleTotalMass::InfotainmentSystem;
			private import Definitions::PartDefinitions::VehicleTotalMass::ClimateControlSystem;
            package PartsTree {
                part vehicle_c : Vehicle { // satisfies <1.4> SafetyRatingRequirement
                    // Powertrain components
                    part engine : Engine; // satisfies <1.2>, <1.3>, <1.5>, <1.6>
                    part transmission : Transmission; // satisfies <1.2>, <1.6>
                    part driveshaft : Driveshaft;
                    part frontAxleAssembly : AxleAssembly; // satisfies <1.7>
                    part rearAxleAssembly : AxleAssembly; // satisfies <1.7>

                    // Other components
                    part fuelTank : FuelTank; // satisfies <1.3>
                    part vehicleSoftware : VehicleSoftware {
                        part vehicleController : VehicleController;
                    }

                    // Feature-specific parts
					part infotainmentSystem : InfotainmentSystem; // satisfies <1.9>
					part climateControlSystem : ClimateControlSystem; // satisfies <1.10>

                    // Attributes
                    attribute passengerCapacity = 5; // satisfies <1.8>
                    attribute mass; // satisfies <1.1>

					// Interfaces
					interface powertrain_mech_1 connect engine.mechanicalOutput to transmission.mechanicalInput;
					interface powertrain_mech_2 connect transmission.mechanicalOutput to driveshaft.mechanicalInput;
					interface powertrain_mech_3 connect driveshaft.mechanicalOutput to rearAxleAssembly.mechanicalInput;
					interface fuel_line connect fuelTank.fuelOutput to engine.fuelInput;

					// Control interfaces
					interface engine_control_if connect vehicleSoftware.vehicleController.engineControl to engine.controlInput;
					interface transmission_control_if connect vehicleSoftware.vehicleController.transmissionControl to transmission.controlInput;
					interface infotainment_control_if connect vehicleSoftware.vehicleController.infotainmentControl to infotainmentSystem.controlInput;
					interface climate_control_if connect vehicleSoftware.vehicleController.climateControl to climateControlSystem.controlInput;
				
                    // V&V 
                    satisfy Requirements::BrakingDistanceRequirement by vehicle_c.engine;
                }
            }
            package ActionTree {
                action performBraking; // satisfies <1.7>
                action operateInfotainment; // satisfies <1.9>
                action controlClimate; // satisfies <1.10>
            }
            package States {
                state vehicleStates {
                    entry;
                    then state Off;
                    then state On;
                    then state Driving;
                    then state Braking; // satisfies <1.7>
                    then done;
                }
            }
            package Requirements {
                private import RequirementDerivation::*;
                private import ModelingMetadata::*; // incudes status info
                //
                requirement vehicleSpecification{
                    subject vehicle:Vehicle;
                    requirement <'1'> vehicleMassRequirement: MassRequirement {
                        doc /* The total mass of the vehicle shall be less than or equal to the required mass.
                        Assume total mass includes a full tank of gas of 60 kg*/
                    }
                    allocate vehicleMassRequirement to PartsTree::vehicle_b.mass;
                }
                //
                requirement <1.1> MassRequirement {
                    doc /*The actual mass shall be less than the required mass*/
                }
                requirement <1.2> MaxSpeedRequirement {
                    doc /*The car shall be capable of reaching a maximum speed of at least 200 km/h*/
                }
                requirement <1.3> FuelEfficiencyRequirement {
                    doc /*The fuel consumption shall not exceed 5 liters per 100 kilometers under standard driving conditions*/
                }
                requirement <1.4> SafetyRatingRequirement {
                    doc /*The car shall achieve a 5-star safety rating according to Euro NCAP standards*/
                }
                requirement <1.5> EmissionsRequirement {
                    doc /*The vehicle shall comply with Euro 6 emissions standards*/
                }
                requirement <1.6> AccelerationRequirement {
                    doc /*The car shall accelerate from 0 to 100 km/h in less than 8 seconds*/
                }
                requirement <1.7> BrakingDistanceRequirement {
                    doc /*The car shall come to a complete stop from 100 km/h within 35 meters on dry asphalt*/
                }
                requirement <1.8> PassengerCapacityRequirement {
                    doc /*The car shall provide seating capacity for at least 5 adult passengers*/
                }
                requirement <1.9> InfotainmentRequirement {
                    doc /*The car shall include a touchscreen infotainment system with navigation and smartphone integration*/
                }
                requirement <1.10> ClimateControlRequirement {
                    doc /*The car shall include an automatic dual-zone climate control system for front and rear passengers*/
                }
            }
        }
    }
    package VehicleAnalysis;
    package FuelEconomyAnalysisModel;
    package ElectricalPowerAnalysis;
    package ReliabilityAnalyis;
}