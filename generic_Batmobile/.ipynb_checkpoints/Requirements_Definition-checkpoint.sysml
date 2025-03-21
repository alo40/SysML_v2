private import Definitions::*;
package Requirements_Definition {
    requirement def VehicleMaxSpeed {
        doc /* The actual speed of the vehicle shall be less than the maximun speed. */
        // stakeholder pm : ProductManagement;
        subject vehicle : Vehicle;
        attribute maxSpeed : SI::SpeedUnit;
    }
}