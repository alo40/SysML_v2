package 'Requirement Definitions' {
    private import SI::*;

    part def Vehicle {
        attribute fuelMass;
        attribute fuelFullMass;
    }

    requirement def <'1'> VehicleMassLimitationRequirement {
        doc /* The actual mass of the subject shall be less or equal than 2000kg. */
        attribute massReqd;
        attribute MaxMass=2000[kg];
        attribute actualMass="Fancy Rechnung";
        require constraint { actualMass <= MaxMass }
    }
}