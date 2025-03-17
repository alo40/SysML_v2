private import Definitions::*;
package Requirements {
    requirement def VehicleMaxSpeed {
        doc /* The actual speed of the vehicle shall be less than the maximun speed. */
        // stakeholder pm : ProductManagement; // not working
        subject vehicle : Vehicle;
        attribute maxSpeed : SI::SpeedUnit;
    }
}