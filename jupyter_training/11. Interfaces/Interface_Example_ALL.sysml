package Interface_Example {
    package Vehicle {
        // private import Port_Example::*;
        
        part def Vehicle;
        
        // interface def FuelInterface {
        // 	end supplierPort : FuelOutPort;
        // 	end consumerPort : FuelInPort;
        // }
        
        part vehicle : Vehicle {	
            // part tankAssy : FuelTankAssembly;		
            // part eng : Engine;
            part tankAssy {
                port fuelTankPort;
            }
            part eng {
                port engineFuelPort;
            }
            
        interface connect tankAssy.fuelTankPort to eng.engineFuelPort;
        

        // 	interface : FuelInterface connect 
        // 		supplierPort ::> tankAssy.fuelTankPort to 
        // 		consumerPort ::> eng.engineFuelPort;
        } 
    }
    package Port_Example {
        
        attribute def Temp;
        
        part def Fuel;
        
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
        
        part def FuelTankAssembly {
            port fuelTankPort : FuelOutPort;
        }
        
        part def Engine {
            port engineFuelPort : FuelInPort;
        }
    }
}