package Variability {
    package DroneProductLine {
        part def Battery;
        part def StandardBattery :> Battery;
        part def PowerBattery :> Battery;

        part def Camera;
        part def StandardCamera :> Camera;
        part def HighResCamera :> Camera;
        part def ThermalCamera :> Camera;

        part def DroneSystem {
            part drones[*]:Drone;
        }

        part def Drone {
            variation part battery : Battery {
                variant part standardBattery : StandardBattery;
                variant part powerBattery : PowerBattery;
            }
            variation part engines[4..8] {
                variant part fourEngines[4];
                variant part sixEngines[6];
                variant part eightEngines[8];
            }
            variation part camera : Camera {
                variant part standard_camera : StandardCamera;
                variant part high_res_camera : HighResCamera;
                variant part thermal_camera : ThermalCamera;
            }
        }
    }
    package DeliveryDroneSystemX42Model {
        private import DroneProductLine::*;
        part def 'DeliveryDroneSystem X42' :> DroneSystem {
            part :>> drones[*] {
                part :>> engines = engines::sixEngines;
                part :>> battery = battery::powerBattery;
                part :>> camera = camera::standard_camera;
            }
        }
        part def 'SurveillanceDroneSystem S88' :> DroneSystem {
            part :>> drones[*] {
                part :>> engines = engines::eightEngines;
                part :>> battery = battery::powerBattery;
                part :>> camera = camera::high_res_camera;
            }
        }
    }
}