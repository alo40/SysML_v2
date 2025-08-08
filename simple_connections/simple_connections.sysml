package system_model {
    package Definitions {
        
    }
    // Part Definitions
    part def User {
        port request;
    }

    part def VCU {
        port signal_out;
    }

    part def Acquisition {
        port request;
    }

    part def Evaluation;

    part def Communication {
        port signal_out;
    }

    part def HMI {
        port request;
        port signal_out;

        part acquisition : Acquisition;
        part evaluation : Evaluation;
        part communication : Communication;

        connect request to acquisition.request;
        connect acquisition to evaluation;
        connect evaluation to communication;
        connect communication.signal_out to signal_out;
    }

    // System Definition
    part def System {
        part user : User;
        part vcu : VCU;
        part hmi : HMI;

        connect user.request to hmi.request;
        connect hmi.signal_out to vcu.signal_out;
    }
}

package system_requirements {
    private import system_model::*;

    // Stakeholder Definitions
    item def ProductManagement;
    item def SystemArchitect;

    // High-Level Requirements
    requirement def UserCommandInput {
        doc /* The system must be capable of receiving commands from a human user. */
        stakeholder pm : ProductManagement;
        subject hmi : HMI;
        // attribute 
        // require constraint 
        require { text = "The HMI shall provide an interface to accept a 'request' from a User."; }
    }

    requirement def CommandTranslation {
        doc /* The system must translate the user's command into a signal for the vehicle's control unit. */
        stakeholder pm : ProductManagement;
        subject hmi : HMI;
        require { text = "The HMI shall translate an incoming 'request' into an outgoing 'signal_out' for the VCU."; }
    }

    requirement def SeparationOfConcerns {
        doc /* To ensure modularity and safety, the user interface logic must be separated from the core vehicle control logic. */
        stakeholder architect : SystemArchitect;
        subject system : System;
        require { text = "The system shall be composed of distinct HMI and VCU components. No direct connection shall exist between the User and the VCU."; }
    }

    requirement def HmiProcessingPipeline {
        doc /* The HMI's internal processing must follow a structured, three-stage pipeline. */
        stakeholder architect : SystemArchitect;
        subject hmi : HMI;
        require { text = "The HMI shall contain three sequential sub-components: Acquisition, Evaluation, and Communication."; }
    }
}
