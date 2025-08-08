package Requirements {
    // Requirements definition
    requirement def MassLimitationRequirement {
        doc /* The actual mass shall be less than or equal to the required mass. */
        attribute massActual : MassValue;
        attribute massReqd : MassValue;
        require constraint { massActual <= massReqd }
    }
    requirement def <'1’> VehicleMassLimitationRequirement :> MassLimitationRequirement {
        doc /* The total mass of a vehicle shall be less than or equal to the required mass. */
        subject vehicle : Vehicle;
        attribute :>> massActual = vehicle.dryMass + vehicle.fuelMass;
        assume constraint { vehicle.fuelMass > 0[kg] }
    }
    requirement def <'2’> DrivePowerInterfaceRequirement {
        doc /* The engine shall transfer its generated torque to the transmission via the clutch interface. */
        subject clutchPort: ClutchPort;
    }
    requirement def <'3’> TorqueGenerationRequirement {
        doc /* The engine shall generate torque as a function of RPM as shown in Table 1. */
        subject generateTorque: GenerateTorque;
    }
    // Requirements usage
    requirement <'1.1’> fullVehicleMassLimit : VehicleMassLimitationRequirement {
        subject vehicle : Vehicle;
        attribute :>> massReqd = 2000[kg];
        assume constraint {
            doc /* Fuel tank is full. */
            vehicle.fuelMass == vehicle.fuelFullMass
        }
    }
    requirement <'1.2’> emptyVehicleMassLimit : VehicleMassLimitationRequirement {
        subject vehicle : Vehicle;
        attribute :>> massReqd = 1500[kg];
        assume constraint {
            doc /* Fuel tank is empty. */
            vehicle.fuelMass == 0[kg]
        }
    }
}
package Design {
    private import ScalarValues::*;
    private import ISQ::*;
    private import RequirementDerivation::*;

    part def Vehicle {
        attribute dryMass: MassValue;
        attribute fuelMass: MassValue;
        attribute fuelFullMass: MassValue;
        part engine: Engine;
        part transmission: Transmission;
        connect engine.clutch to transmission.clutch;
    }

    part def Engine {
        port clutch: ClutchPort;
        action generateTorque: GenerateTorque;
    }

    part def Transmission {
        port clutch: ClutchPort;
    }

    port def ClutchPort;
    action def GenerateTorque;

    // Concrete Vehicle Design and Satisfaction
    part myCar : Vehicle {
        attribute dryMass = 1400[kg];
        attribute fuelFullMass = 70[kg];

        // // Satisfaction of mass requirements
        // satisfy fullVehicleMassLimit by {
        //     /* full mass = 1400 + 70 = 1470 kg, which is <= 2000 kg. */
        // }
        // satisfy emptyVehicleMassLimit by {
        //     /* dry mass = 1400 kg, which is <= 1500 kg. */
        // }

        // // Satisfaction of interface requirement
        // satisfy DrivePowerInterfaceRequirement by {
        //     /* The connection between engine.clutch and transmission.clutch
        //        in the Vehicle definition satisfies this. */
        //     subject = self.engine.clutch;
        // }

        // // Satisfaction of behavioral requirement
        // satisfy TorqueGenerationRequirement by {
        //     /* The engine's generateTorque action satisfies this.
        //        Verification would require comparing its performance to Table 1. */
        //     subject = self.engine.generateTorque;
        // }
    }
}