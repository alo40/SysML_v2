package 'Part Tree Example' {
    private import ScalarValues;
    part def Electrical {
        attribute Mass;
    }
    part def Mechanical {
        attribute Mass;
    }

    part Automobile {
        part 'Drive Train' {
            part Battery : Electrical {
                attribute redefines Mass = 150;
            }
            part Motor : Electrical {
                attribute redefines Mass = 100;
            }
            attribute DriveTrainMass = Battery.Mass + Motor.Mass;
        }
        part Chassis {
            part Suspension : Mechanical {
                attribute redefines Mass = 100;
            }
            part Body : Mechanical {
                attribute redefines Mass = 150;
            }
            attribute ChassisMass = Suspension.Mass + Body.Mass;
        }
        attribute TotalMass = 'Drive Train'.DriveTrainMass + 'Chassis'.ChassisMass;
    }

    requirement def MassLimitation {
        doc /* Total mass of the Automobile must not
            exceed 500 */
        attribute MassActual = Automobile.TotalMass;
        attribute MassLimit = 500;
    }
}