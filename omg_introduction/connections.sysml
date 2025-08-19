package Connections {
    part def WheelHubAssembly;
    part def WheelAssembly;
    part def TireBead;
    part def Wheel;
    part def Tire;
    part def TireMountingRim;
    part def LugBoltMountingHole;
    part def LugBoltJoint;
    part def Hub;
    part def LugBoltThreadableHole;
    connection def PressureSeat {
        end [1] part bead : TireBead;
        end [1] part mountingRim : TireMountingRim;
    }
    part wheelHubAssembly : WheelHubAssembly {
        part wheel : WheelAssembly [1] {
            part t : Tire [1] {
                part bead : TireBead [2];
            }
            part w : Wheel [1] {
                part rim : TireMountingRim [2];
                part mountingHoles : LugBoltMountingHole [5];
            }
            connection : PressureSeat connect bead references t.bead to mountingRim references w.rim;
        }
        part lugBoltJoints : LugBoltJoint [0..5];
        part hub : Hub [1] {
            part h : LugBoltThreadableHole [5];
        }
        connect [0..1] lugBoltJoints to [1] wheel.w.mountingHoles;
        connect [0..1] lugBoltJoints to [1] hub.h;
    }
}