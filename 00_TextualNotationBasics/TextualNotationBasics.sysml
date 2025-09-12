package TextualNotationBasics {
    package Requirements {
        constraint def IsFull {
            in tank : FuelTank;
            tank.fuelLevel == tank.maxFuelLevel
        }
        part def Vehicle {
            part fuelTank : FuelTank;
            constraint tankIsFull : IsFull {
                in tank = fuelTank;
            }
        }
        requirement def MassRequirement {
            subject vehicle : Vehicle;
            attribute massActual : ISQ::MassValue;
            attribute massLimit : ISQ::MassValue;
            require constraint { massActual <= massLimit }
        }
        requirement <R1> vehicleMass : MassRequirement {
            attribute :>> massActual = vehicle.mass;
            attribute :>> massLimit = 1800 [kg];
        }
        satisfy R1 by vehicle;
    }
    package Actions {
        action def StartEngine {
            in ignitionSignal : Boolean;
            out status : EngineStatus;
        }
        action def Drive {
            action accelerate : Accelerate;
            first start then accelerate;
        }
        part vehicle : Vehicle {
            action driveVehicle : Drive;
            action pressGas {
                perform driveVehicle;
            }
        }
        state def EngineStates {
            state Off;
            state Running;
        }
    }
    package Parts {
        part def Engine;
        part def Vehicle {
            attribute mass : MassValue;
            attribute wheels : Integer;
        }
        part def SportsCar :> Vehicle {
            :>> wheels = 4;
        }
        part vehicle : Vehicle {
            :>> mass = 1500 [kg];
            part engine : Engine;
        }
    }
    package Ports {
        port def FuelingPort {
            attribute flowRate : Real;
            out fuelOut : Fuel;
            in fuelIn : Fuel;
        }
        port fuelTankPort : FuelingPort;
    }
    package Connections {
        connection def DeviceConn {
            end part hub : Hub;
            end part device : Device;
            attribute bandwidth : Real;
        }
        connection connection : DeviceConn {
            end part hub ::> mainSwitch;
            end part device ::> sensorFeed;
    }
}