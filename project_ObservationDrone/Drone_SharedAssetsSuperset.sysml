library package Drone_SharedAssetsSuperset {
    
    package Drone {
               
        public import DroneBattery::**;
        public import DroneEngine::**;
        public import DroneBody::**;
        public import DroneFlightControlSoftware::**;  
        
        abstract part def Drone {
            
            // Attributes
            attribute massActual : ISQ::MassValue;
            
            
            // Spatial extent
            item :>> shape = body.shape;
            item boundingBox :> boundingShapes = body.boundingBox;
            
            // Timeslices            
            timeslice parking {
                snapshot startCharging {
                    // model some start charging conditions
                }
                then snapshot stopCharging;
            }
            then timeslice flying {
                :>> battery[1];
            }
            
            // States
            state droneStates {
                entry; then off;

                state off;
                accept SigSwitchOn then standBy;
                state standBy;
                accept SigSwitchOff then off;
                transition standBy_charging
                    first standBy
                    accept SigStartCharging
                    then charging;
                transition standBy_ready 
                    first standBy
                    accept SigActivate
                    then ready;
                state charging;
                    transition charging_standBy
                        first charging
                        accept SigStopCharging
                        then standBy;
                state ready;
                accept SigDeactivate then standBy;
                transition ready_flying
                    first ready
                    accept SigStartFlying 
                    then flying;
                
                state flying;    
                accept SigStopFlying then ready;
            }
            
            // Signals
            attribute def SigStartCharging;
            attribute def SigStopCharging;
            attribute def SigSwitchOn;
            attribute def SigSwitchOff;
            attribute def SigActivate;
            attribute def SigDeactivate;
            attribute def SigStartFlying;
            attribute def SigStopFlying;
            
            // Power
            part battery : DroneBatteryVariation;
            message notifyBatteryLow of SigBatteryLow from battery.batteryManagementSystem to flightControl;
            
            // Engines
            variation attribute numberOfEngines : ScalarValues::Integer {
                variant attribute fourEngines = 4;
                variant attribute sixEngines = 6;
            }
            assert constraint { 
                (numberOfEngines == numberOfEngines::sixEngines) and 
                (battery == DroneBattery::DroneBattery_Parts::DroneBatteryVariation::longDistanceBattery) 
            }
            satisfy Drone_FeatureModel::droneFeatures.numberOfEngines by numberOfEngines;                
            part engine[numberOfEngines] : DroneEngine;
            
            // Body
            part body :> droneBodyVariation;
            
            // Flight Control
            part flightControl :> droneFlightControlSoftwareVariation;
        }

        //
        // Drone Requirements
        //
        package Drone_Requirements {
        
            requirement droneStakeholderRequirements {
                subject drone : Drone;
                
                require droneEngineStakeholderRequirements;
                require droneBatteryStakeholderRequirements;
                
                variation requirement maximumTakeoffWeight {
                    variant requirement mtqw_Quadcopter : MTOW_Quadcopter;
                    variant requirement mtqw_Hexacopter : MTOW_Hexacopter;
                }
            }

            requirement def <'D-REQ-22'> MTOW {
                
                subject drone : Drone;
                
                doc /*
                    * The maximum takeoff weight (MTOW) for a drone shall not exceed [X] kilograms. 
                    * This includes the weight of the drone itself, its battery, payload, and any additional 
                    * attached equipment. [X] depends on the number of engines.
                    */
                    
                attribute mtow : ISQ::MassValue;
                require constraint { drone.massActual <= mtow }
            }
            
            
            requirement def <'D-REQ-23'> MTOW_Quadcopter :> MTOW {
                doc /*
                    * The maximum takeoff weight (MTOW) for a quadcopter equipped with 4 engines shall not exceed 
                    * 15 kilograms. 
                    */
                :>> mtow = 15[SI::kg];
            }

            requirement def <'D-REQ-24'> MTOW_Hexacopter :> MTOW {
                doc /*
                    * The maximum takeoff weight (MTOW) for a hexacopter equipped with 6 engines shall not exceed 
                    * 25 kilograms. 
                    */
                :>> mtow = 25[SI::kg];
            }
        }
        
        //
        // Drone Use Cases
        //
        package Drone_UseCases {
            use case observeArea {
                subject drone : Drone;
                in item hi_observationArea;
            
                first start;
                then action defineObservationArea {
                    in item hi_observationArea = observeArea::hi_observationArea;
                    out item observationArea;
                }
                then action approachArea {
                    in item observationArea;
                }
                then action flyObservationPatterns;
                then action returnToHomeBase;
                then done;            
            
                flow defineObservationArea.observationArea to approachArea.observationArea;
            }
        
            use case chargeDrone {
                subject drone : Drone;
            
                first start;
                then action plugDrone;
                then action chargeDroneBatteries;
                then done;
            }        
        }
    }
     
    //
    // Drone Engine Shared Assets
    //
    package DroneEngine {
        
        package DroneEngine_StakeholderRequirements {
            
            import DroneEngine_Parts::*;
            
            variation requirement droneEngineStakeholderRequirements {
                variant requirement droneEngineStandardStakeholderRequirements {
                    
                    subject engine : DroneEngine;
                                        
                    requirement power : Power;
                    requirement efficiency : Efficiency;
                    requirement durability : Durability;
                    requirement reliability : Reliability;
                    requirement lightweight : Lightweight;
                    requirement control : Control;
                    requirement compatibility : Compatibility;
                    requirement safety : Safety;
                    requirement costEffective : CostEffective;
                }
                variant requirement droneEngineLowNoiseStakeholderRequirements :> droneEngineStandardStakeholderRequirements {
                    requirement lowNoise : LowNoise;
                }
            }
            
            requirement def <'DE-REQ-1'> Power {
                doc /*
                    * The engine shall provide enough power to lift the drone off the ground and keep it in the air. 
                    * The power output shall be appropriate for the size and weight of the drone.
                    */
            }
            requirement def <'DE-REQ-2'> Efficiency {
                doc /*
                    * The engine shall be efficient, allowing the drone to fly for an extended period on a single charge. 
                    * The engine shall be designed to minimize energy loss through friction and heat.
                    */
            }
            requirement def <'DE-REQ-3'> Durability {
                doc /*
                    * The engine shall be able to withstand the stress of continuous use and exposure to the elements. 
                    * It shall be able to operate in a wide range of temperatures and weather conditions.
                    */
            }
            requirement def <'DE-REQ-4'> Reliability {
                doc /*
                    * The engine shall be reliable, with minimal downtime or maintenance requirements. 
                    * It shall be designed with high-quality components and undergo rigorous testing before deployment.
                    */
            }
            requirement def <'DE-REQ-5'> LowNoise {
                doc /*
                    * The engine shall produce minimal noise to avoid disturbing the environment or attracting unwanted attention.
                    */
            }
            requirement def <'DE-REQ-6'> Lightweight {
                doc /*
                    * The engine shall be lightweight, allowing for maximum payload capacity and longer flight times.
                    */
            }
            requirement def <'DE-REQ-7'> Control {
                doc /*
                    * The engine shall be easy to control, allowing for precise maneuverability and responsiveness to commands.
                    */
            }
            requirement def <'DE-REQ-8'> Compatibility {
                doc /*
                    * The engine shall be compatible with the drone's power supply and electronic components.
                    */
            }
            requirement def <'DE-REQ-9'> Safety {
                doc /*
                    * The engine should be designed with safety in mind, minimizing the risk of injury or damage in case of malfunction. 
                    * It should have fail-safe mechanisms to prevent accidents and minimize damage in case of emergency.
                    */
            }
            requirement def <'DE-REQ-10'> CostEffective {
                doc /*
                    * The engine shall be cost-effective, balancing performance and quality with affordability. 
                    * It shall provide value for money, with a low cost of ownership and maintenance.            
                    */
            }            
        }
        
        package DroneEngine_Parts {
            part def DroneEngine {
                enum propKind : PropKind;
            
                enum def PropKind {
                    enum clockwise;
                    enum counterclockwise;
                }            
            }
        }                        
    }
    
    
    //
    // Drone Body Shared Assets
    //

    package DroneBody {
        
        package DroneBody_Parts {
            
            import DroneBody_Domain::*;

            variation part droneBodyVariation : DroneBody {
                variant part droneBody4Engines : DroneBody {
                    // to be done: redefines size
                    satisfy Drone_FeatureModel::droneFeatures.numberOfEngines.fourEngines by self;
                }
                variant part droneBody6Engines : DroneBody {
                    // to be done: redefines size
                    satisfy Drone_FeatureModel::droneFeatures.numberOfEngines.sixEngines by self;
                }
            }            
            
            abstract part def DroneBody {
                // Spatial extent
                item :>> shape : ShapeItems::Cylinder {
                    :>> height = 20 [SI::cm];
                    :>> base.shape : ShapeItems::Circle {
                        :>> radius = 60 [SI::cm];
                    }
                }
                item boundingBox : ShapeItems::Box [1] :> boundingShapes {
                    :>> length = 120 [SI::cm];
                    :>> width  = 120 [SI::cm];
                    :>> height = 20 [SI::cm];
                }            
                
                // BodyColorKind is an enumeration definition which is already a kind of variation
                attribute bodyColor : BodyColorKind {
                    enum redColor redefines red {
                        satisfy Drone_FeatureModel::droneFeatures.bodyColor.redBody by self;
                    }
                }
            }
        }
        
        package DroneBody_Domain {            
            enum def BodyColorKind {
                enum red;
                enum white;
                enum blue;
                enum black;
            }
        }
    }
    
    
    //
    // Drone Flight Control Software Shared Assets
    //
    
    package DroneFlightControlSoftware {
        
        package DroneFlightControlSoftware_Parts {
            
            variation part droneFlightControlSoftwareVariation : DroneFlightControlSoftware {
                variant part droneFlightControl4Engines : DroneFlightControlSoftware {
                    satisfy Drone_FeatureModel::droneFeatures.numberOfEngines.fourEngines by self;
                }
                variant part droneFlightControl6Engines : DroneFlightControlSoftware {
                    satisfy Drone_FeatureModel::droneFeatures.numberOfEngines.sixEngines by self;
                }
            }
                        
            abstract part def DroneFlightControlSoftware;
        }
    }

    //
    // Drone Battery Shared Assets
    //   
    
    package DroneBattery {
        
        package DroneBattery_Domain {
            attribute def SigBatteryLow {
                attribute capacity : ISQElectromagnetism::ElectricChargeValue;
            }
        }
        
        package DroneBattery_Parts {

            variation part def DroneBatteryVariation :> DroneBattery {
                variant part standardBattery : StandardDroneBattery {
                    satisfy Drone_FeatureModel::droneFeatures.batteryKind.standardBattery by self;
                }
                variant part longDistanceBattery : LongDistanceDroneBattery {
                    satisfy Drone_FeatureModel::droneFeatures.batteryKind.longDistanceBattery by self;
                }
            }            
            
            abstract part def DroneBattery {
                // Attributes
                attribute weight : ISQBase::MassValue; 
                attribute maxCapacity : ISQElectromagnetism::ElectricChargeValue;
                enum currentCapacityLevel : BatteryCapacityKind;
                enum def BatteryCapacityKind :> ScalarValues::Integer {
                    enum full = 100;
                    enum medium = 50;
                    enum low = 30;
                    enum critical = 15;
                }
            
                // Parts
                part batteryCells {
                    doc /* The battery cells are the main components of the drone battery 
                         * that store the electrical energy. These cells are usually Lithium Polymer (LiPo) 
                         * or Lithium-Ion (Li-Ion) cells.
                        */
                }
                part batteryManagementSystem {
                    doc /* The Battery Management System (BMS) is a control unit that manages the charging and 
                         * discharging of the battery cells. It ensures that the cells are charged and discharged 
                         * correctly and safely.
                         */
                }
                part protectionCircuit {
                    doc /* The protection circuit is a safety mechanism that protects the battery from overcharging, 
                         * over-discharging, and short circuits.
                        */
                }
                part powerConnector {
                    doc /* The power connector is the interface that connects the battery to the drone's power system. 
                        * It delivers the electrical energy from the battery to the drone.
                        */
                }
                part chargingInterface {
                    doc /* The charging interface is the interface that connects the battery to the charger. 
                         * It allows the battery to be charged safely and efficiently.
                        */
                }
                part batteryIndicator {
                    doc /* The battery indicator is a component that displays the remaining battery charge. 
                         * It allows the pilot to monitor the battery level and plan flight time accordingly.
                        */
                }
                part communicationInterface {
                    doc /* The communication interface is a component that allows the battery to communicate 
                         * with the drone's flight controller. It provides important battery information such 
                         * as voltage, current, and temperature to the flight controller.
                        */
                    }
                part firmware {
                    doc /* The firmware is the software that runs on the battery management system. 
                         * It controls the charging and discharging of the battery cells and ensures 
                         * that the battery operates safely and efficiently.
                        */
                }
            }
                             
            part def StandardDroneBattery :> DroneBattery {
                :>> weight = 275[SI::g];
                :>> maxCapacity = 13680[SI::'s⋅A'];
            }
            part def LongDistanceDroneBattery :> DroneBattery {
                :>> weight = 315[SI::g];
                :>> maxCapacity = 18000[SI::'s⋅A'];
            }
        }
            
        package DroneBattery_SystemRequirements {
            
            import RequirementDerivation::*;
            import DroneBattery_StakeholderRequirements::*;
            import DroneBattery_Parts::*;
            
            variation requirement droneBatterySystemRequirements {
                variant requirement droneBatteryStandardSystemRequirements {
                    satisfy Drone_FeatureModel::droneFeatures.batteryKind.standardBattery by self;
                    subject battery : DroneBattery;    
                }
                variant requirement droneBatteryLongDistanceSystemRequirements {
                    satisfy Drone_FeatureModel::droneFeatures.batteryKind.longDistanceBattery by self;
                    subject battery : DroneBattery;
                    
                    requirement longDistanceCapacity : LongDistanceCapacity;
                    #derivation connection {
                        end #original ::> droneBatteryStakeholderRequirements.highCapacity;
                        end #derive ::> longDistanceCapacity;
                    }
                }                                               
            }
            satisfy Drone_FeatureModel::droneFeatures.batteryKind by droneBatterySystemRequirements;
            
            requirement def <'DB-REQ-421'> LongDistanceCapacity {
                doc /* The battery shall have a capacity of at least 13860 sA, which provides enough power for extended flight times. */
                    
                subject battery : DroneBattery;
                
                assert constraint {
                    (battery.maxCapacity >= 13860[SI::'s⋅A'])
                }
            }
        }
        
        package DroneBattery_StakeholderRequirements {
            
            import DroneBattery_Parts::*;
            
            requirement droneBatteryStakeholderRequirements {
                
                subject battery : DroneBattery;
                
                requirement lightweight : Lightweight;
                requirement highCapacity : HighCapacity;
                requirement fastCharging : FastCharging;
                requirement longLife : LongLife;
                requirement safe : Safe;
                requirement compatible : Compatible;
                requirement reliable : Reliable;
                requirement affordable : Affordable;
                requirement easyToInstall : EasyToInstall;
            }
            
            requirement def <'DB-REQ-2'> Lightweight {
                doc /*
                     * A drone battery shall be lightweight to keep the overall weight of the drone 
                     * to a minimum, which is essential for stable flight.
                    */
            }

            requirement def <'DB-REQ-3'> HighCapacity {
                doc /*
                     * A drone battery shall have a high capacity to provide the drone with enough power 
                     * to fly for a reasonable amount of time.
                    */
            }

            requirement def <'DB-REQ-4'> FastCharging {
                doc /*
                     * A drone battery shall be able to charge quickly so that the drone can 
                     * get back in the air as soon as possible.
                    */
            }

            requirement def <'DB-REQ-5'> LongLife {
                doc /*
                     * A drone battery shall have a long life to avoid the need for frequent replacements.
                    */
            }

            requirement def <'DB-REQ-6'> Safe {
                doc /*
                     * A drone battery shall be designed to be safe, with features such as overcharge protection, 
                     * short circuit protection, and temperature control.
                    */
            }

            requirement def <'DB-REQ-7'> Compatible {
                doc /*
                     * A drone battery shall be compatible with the drone's power system to ensure proper functioning.
                    */
            }
            
            requirement def <'DB-REQ-8'> Reliable {
                doc /*
                     * A drone battery shall be reliable, with consistent performance and the ability to withstand 
                     * the stresses of flight and charging cycles.
                    */
            }

            requirement def <'DB-REQ-9'> Affordable {
                doc /*
                     * A drone battery shall be reasonably priced, to avoid being a significant expense for drone pilots.
                    */
            }
            
            requirement def <'DB-REQ-10'> EasyToInstall {
                doc /*
                     * A drone battery shall be easy to install and remove to make it easy for pilots to swap out batteries when necessary.
                    */
            }
        }
    }    
}
