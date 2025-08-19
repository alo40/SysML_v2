package Flows_Interfaces {
    // private import ISQBase::*;
    // private import ISQ::*;
    // private import SI::*;
    attribute def Temp;
    item def Fuel;
    interface def FuelInterface {
        end supplierPort : FuelOutPort;
        end consumerPort : FuelInPort;
        flow supplierPort.fuelSupply to consumerPort.fuelSupply;
        flow consumerPort.fuelReturn to supplierPort.fuelReturn;
    }
    part vehicle : Vehicle {
        part tankAssy : FuelTankAssembly;
        part eng : Engine;
        interface : FuelInterface connect
            supplierPort ::> tankAssy.fuelTankPort to
            consumerPort ::> eng.engineFuelPort;
    }
    port def FuelOutPort {
        attribute temperature : Temp;
        out item fuelSupply : Fuel;
        in item fuelReturn : Fuel;
    }
    port def FuelInPort {
        attribute temperature : Temp;
        in item fuelSupply : Fuel;
        out item fuelReturn : Fuel;
    }
    part def Vehicle;
    part def FuelTankAssembly {
        port fuelTankPort : FuelOutPort;
    }
    part def Engine {
        port engineFuelPort : FuelInPort;
    }
}