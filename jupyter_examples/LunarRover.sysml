package LunarRover_architecture {

    item def Energy;

    port def PowerOutPort {
        out item powerSupply: Energy;
    }

    interface def PowerInterface {
        end PowerOut: PowerOutPort;
        end PowerIn: ~PowerOutPort;
    }

    part LunarRover {
        part mobilitySubsystem {
            part wheel[4];
            part brake[4];
            part motor[4] {
                port powerIn: ~PowerOutPort;
            }
        }

        part body;
        part battery {
            port powerOut: PowerOutPort;
        }

        part communicator {
            port powerIn: ~PowerOutPort;
        }

        part camera {
            port powerIn: ~PowerOutPort;
        }

        part sensorSubsystem {
            part proximitySensor[2] {
                port powerIn: ~PowerOutPort;
            }
            part temperatureSensor {
                port powerIn: ~PowerOutPort;
            }
            part pressureSensor {
                port powerIn: ~PowerOutPort;
            }
        }

        interface: PowerInterface connect
            PowerOut ::> battery.powerOut to
            PowerIn ::> communicator.powerIn;

        connect body to battery;
        connect body to mobilitySubsystem;
        connect body to communicator;
        connect body to camera;
        connect body to sensorSubsystem.proximitySensor;
        connect body to sensorSubsystem.temperatureSensor;
        connect body to sensorSubsystem.pressureSensor;

        connect battery.powerOut to mobilitySubsystem.motor.powerIn;
        connect battery.powerOut to camera.powerIn;
        connect battery.powerOut to sensorSubsystem.proximitySensor.powerIn;
        connect battery.powerOut to sensorSubsystem.temperatureSensor.powerIn;
        connect battery.powerOut to sensorSubsystem.pressureSensor.powerIn;

        connect mobilitySubsystem.motor to mobilitySubsystem.wheel;
        connect mobilitySubsystem.brake to mobilitySubsystem.wheel;
    }
}
