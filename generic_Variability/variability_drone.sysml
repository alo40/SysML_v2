package variability_Drone {
    part def Drone {
        variation part engines[4..8] {
            variant part fourEngines[4];
            variant part sixEngines[6];
            variant part eightEngines[8];
        }
        variation part battery {
            variant part standardBattery;
            variant part powerBattery;
        }
    }
}