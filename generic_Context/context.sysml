package Context {
    part product {
        port input : ~UserIP;
        port power : ~PowerIP;
        port visual;
        port signal;
    }
    part user { port request : UserIP; }
    part battery { port power : PowerIP; }
    interface i01 : UserInterface connect user.request to product.input; 
    interface i02 : PowerInterface connect battery.power to product.power;

    // Interface Definitions
    interface def UserInterface {
        end supplierPort : UserIP;
        end consumerPort : ~UserIP;
        flow of Press from supplierPort.press to consumerPort.press;
    }
    interface def PowerInterface {
        end supplierPort : PowerIP;
        end consumerPort : ~PowerIP;
        flow of Power from supplierPort.power to consumerPort.power;
    }
    // Port Definitions
    port def UserIP { out item press; }
    port def PowerIP { out item power; }
    // Item Definitions
    item def Press { attribute force; }
    item def Power { attribute voltage; }

} 