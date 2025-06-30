package Logical {
    public import Functions::*;
    part def logicalSystem {
        part def Interface {
            part def functionActivation;
            part def hapticFeedback;
            part def visualPerception;
        }
        part def Power {
            part def extSupply;
            part def intSupply;
            part def powerFilter;
        }
        part def Communication {
            part def extComm;
            part def intComm;
            part def commFilter;
        }
        part def Processing {
            part def diagnostic;
            part def evaluation;
            part def safety;
            part def security;
        }
    }
}