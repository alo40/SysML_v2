package Generic_Example {
    package Physical_Breakdown {
        
        part def SOI {
            part Tech_1;
            part Tech_2;
            part Tech_3;
            part Tech_4;
            
            port Port_Generic;
        }
        part def SOI_1 :> SOI;
        part def Tech_1 {
            action Acquistion;
            action Conditioning;
            action Evaluation;
        }
        
        port def Port_1;
        port def Port_2;
        
        flow def Data {
            end port Port_1;
            end port Port_2;
        }
        
        part System_1 : SOI {
            part HMI :>> Tech_1;
            port input_1 :>> Port_Generic;
            // flow of Data from Infotaiment to Processing;
        }
        part System_2 : SOI {
             port output_2 : Port_2;
        }
        part System_3 : SOI;
        flow : Data 
            from System_1.input_1 
              to System_2.output_2;
    }
}