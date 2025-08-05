package 'OMG Requirements Mass Scenario' {
    import 'OMG Requirements Mass'.*;
    private import ScalarValues::*;
    private import ISQ::*;

    // Instantiate a specific vehicle that will be the subject of our test.
    // This vehicle has a dry mass of 1450 kg and can hold 50 kg of fuel.
    part testVehicle : Vehicle {
        attribute dryMass = 1450[kg];
        attribute fuelFullMass = 50[kg];
        attribute fuelMass = 50[kg]; // Assume it starts with a full tank.
    }

    // Define a verification case to test the 'fullVehicleMassLimit' requirement.
    verification case verifyFullMassLimit {
        doc /*
         * This case verifies that our 'testVehicle' with a full tank of fuel
         * satisfies the 'fullVehicleMassLimit' requirement.
         * The total mass (1450 + 50 = 1500 kg) should be <= 2000 kg.
         */
        subject req: fullVehicleMassLimit;

        // Bind the subject of the requirement to our specific test vehicle.
        bind subject of req to testVehicle;

        // The objective is to check if the requirement is satisfied.
        objective checkMass {
            satisfy req
        }
    }

    // Define a verification case to test the 'emptyVehicleMassLimit' requirement.
    verification case verifyEmptyMassLimit {
        doc /*
         * This case verifies that our 'testVehicle' with an empty tank of fuel
         * satisfies the 'emptyVehicleMassLimit' requirement.
         * The total mass (1450 + 0 = 1450 kg) should be <= 1500 kg.
         */
        subject req: emptyVehicleMassLimit;
        bind subject of req to testVehicle with (fuelMass = 0[kg]);
        objective checkMass { satisfy req }
    }
}

