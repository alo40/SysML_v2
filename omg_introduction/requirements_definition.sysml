package 'OMG Requirements Mass' {
    private import ScalarValues::*;
    private import ISQ::*;
    private import RequirementDerivation::*;

    part def Vehicle {
        attribute dryMass: MassValue;
        attribute fuelMass: MassValue;
        attribute fuelFullMass: MassValue;
    }
    port def ClutchPort;
    action def GenerateTorque;

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