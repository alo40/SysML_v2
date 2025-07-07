package Drone_FeatureModel {
    
    requirement <'FD1'> droneFeatures : Feature {
        
        doc /* Root feature of the drone product line */
                    
        requirement <'FD1.1'> numberOfEngines : Feature {
            doc /* The drone product line offers drones with four or with six engines. */

            :>> bindingTime = BindingTimeKind::Design;
                
            requirement <'FD1.1.1'> fourEngines [0..1] : Feature {
                doc /* A drone with four engines. */
            }
            requirement <'FD1.1.2'> sixEngines [0..1] : Feature {
                doc /* A drone with six engines. */
                require batteryKind.longDistanceBattery;
            }
            
            require constraint {
                (fourEngines == null) xor (sixEngines == null)
            }        
        }
        
        requirement <'FD1.2'> batteryKind : Feature {
            doc /* The drone product line offers standard batteries and more powerful batteries for long distance flights. */

            :>> bindingTime = BindingTimeKind::Operation;
                
            requirement <'FD1.2.1'> standardBattery [0..1] : Feature {
                doc /* Standard battery with a capacity of at least 3000 mAh. */
            }
            requirement <'FD1.2.2'> longDistanceBattery [0..1] : Feature {
                doc /* Battery for long distance flights with a capacity of at least 5000 mAh. */
            }
        }
        
        requirement <'FD1.3'> safetyFeatures [0..1] : Feature {
            :>> bindingTime = BindingTimeKind::Design;
            requirement <'FD1.3.1'> geoFencing [0..1] : Feature;
            requirement <'FD1.3.2'> returnHome [0..1] : Feature;
            requirement <'FD1.3.3'> collisionAvoidance [0..1] : CollisionAvoidance;
        }
        
        requirement <'FD1.4'> autonomousFlight [0..1] : Feature  {
            :>> bindingTime = BindingTimeKind::Design;
            requirement <'FD1.4.1'> collisionAvoidance [0..1] : CollisionAvoidance;
            requirement <'FD1.4.2'> flightPathDefinition[0..1] : Feature;
            requirement <'FD1.4.3'> flightDestinationDefinition[0..1] : Feature;
        }
        
        requirement def CollisionAvoidance :> Feature;
        
        requirement <'FD1.5'> flightControls [0..1] : Feature {
            :>> bindingTime = BindingTimeKind::Production;
            requirement <'FD1.5.1'> flyObservationPatterns[0..1] : Feature;
            requirement <'FD1.5.2'> flyCameraPatterns[0..1] : Feature;
            requirement <'FD1.5.3'> flyFunPatterns[0..1] : Feature;
        }
        
        requirement <'FD1.6'> bodyColor : Feature {
            :>> bindingTime = BindingTimeKind::Production;
            requirement <'FD1.6.1'> redBody[0..1] : Feature;
            requirement <'FD1.6.2'> whiteBody[0..1] : Feature;
            requirement <'FD1.6.3'> blueBody[0..1] : Feature;
            requirement <'FD1.6.4'> blackBody[0..1] : Feature;  
        }
        
        //
        // Feature Configurations
        //
        requirement <'FDFC1'> standardObserverationDrone :> droneFeatures {
            doc /* A standard drone with basic capabilities. */
            :>> numberOfEngines = numberOfEngines.fourEngines;
            :>> batteryKind {
                :>> standardBattery[0];
                :>> longDistanceBattery[1];
            }
            :>> safetyFeatures[0];
            :>> autonomousFlight[1] {
                :>> collisionAvoidance[0];
                :>> flightPathDefinition[1];
                :>> flightDestinationDefinition[0];
            }
            :>> flightControls {
                :>> flyObservationPatterns[1];
                :>> flyCameraPatterns[0];
                :>> flyFunPatterns[0];
            }
            :>> bodyColor {
                :>> redBody[0];
                :>> whiteBody[0];
                :>> blueBody[1];
                :>> blackBody[0];
            }
        }

        requirement <'FDFC2'> forestFireObserverationDrone :> droneFeatures {
            :>> numberOfEngines = numberOfEngines.sixEngines;
            :>> batteryKind {
                :>> standardBattery[0];
                :>> longDistanceBattery[1];
            }
            :>> safetyFeatures[1] {
                :>> collisionAvoidance[1];
                :>> returnHome[1];
            }
            :>> autonomousFlight[1] {
                :>> collisionAvoidance[1];
                :>> flightPathDefinition[1];
                :>> flightDestinationDefinition[1];
            }
            :>> flightControls {
                :>> flyObservationPatterns[1];
                :>> flyCameraPatterns[0];
                :>> flyFunPatterns[0];
            }            
            :>> bodyColor {
                :>> redBody[1];
                :>> whiteBody[0];
                :>> blueBody[0];
                :>> blackBody[0];
            }            
        }     
    }
    
    requirement def Feature {
        attribute bindingTime : BindingTimeKind;
    }
    
    enum def BindingTimeKind {
        enum Design;
        enum Production;
        enum Operation;
    }    
}
