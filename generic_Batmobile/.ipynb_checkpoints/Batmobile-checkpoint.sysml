package dont_Panic {    
    part def Vehicle {
        item driver;
        part engine;
        attribute actualSpeed : SI::SpeedUnit;
    }   
    part def Wheel {
        attribute pressure;
    }
    part def Batmobile specializes Vehicle {
        part seat[2];
        part body;
        part frontLeftWheel : Wheel;
    }
}