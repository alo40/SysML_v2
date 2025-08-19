package dontPanic_Interfaces {
    part def Vehicle {
        item driver;
        part engine;
        attribute actualSpeed :
        SI::SpeedUnit;
    }
    part def Batmobile :> Vehicle {
        part def Wheel {attribute pressure;}
        part wheels[4] : Wheel;
        part battery {
            port powerPort : PowerIP;
            attribute capacity;
        }
        part batmobileEngine :>> engine {
            port enginePort : ~PowerIP;
        }
        interface bat2eng : PowerInterface connect
            battery.powerPort to batmobileEngine.enginePort;
    }
    interface def PowerInterface {
        end supplierPort : PowerIP;
        end consumerPort : ~PowerIP;
        flow of Power from supplierPort.power to consumerPort.power;
    }
    port def PowerIP {out item power : Power;}
    item def Power {attribute value;}
}