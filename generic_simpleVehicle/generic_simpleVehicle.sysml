package SimpleVehicleModel {
    public import ISQ::*;
    package Definitions {
        part def Vehicle {
            attribute mass:>ISQ::mass;
            attribute velocity:>ISQ::speed;
            attribute acceleration:>ISQ::acceleration;
            perform action providePower;
            perform action provideBraking;
            perform action controlDirection;
        }
    }
    package Configurations {

    }
}