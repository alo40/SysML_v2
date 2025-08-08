package Electronics_Gemini {
    package Definitions {
        abstract part def Product;
        abstract part def Component {
            port a;
            port b;        
        }
        part def Resistor :> Component {
            attribute resistance :> ISQ::resistance;
        }
        part def CircuitBoard :> Component {
            port power :>> a;
            port ground :>> b;
        }
        part def Microswitch :> Component {
            attribute operatingForce :> ISQ::force;
            attribute operatingCycles : ScalarValues::Integer;
        }
        part def LED :> Component {
            attribute color : ScalarValues::String;
            port cathode :>> a;
            port anode :>> b;
        }
        part def Buzzer :> Component {
            attribute soundLevel :> ISQ::soundIntensity;
        }
        part def Potentiometer { // Not a standard 2-port component
            attribute maxResistance :> ISQ::resistance;
            port terminal1;
            port wiper;
            port terminal2;
        }
        part def SevenSegmentDisplay {
            port seg_a;
            port seg_b;
            port seg_c;
            port seg_d;
            port seg_e;
            port seg_f;
            port seg_g;
            port common_cathode;
        }
        part def VoltageRegulator {
            port vin;
            port vout;
            port gnd;
        }
        abstract part def I2C_Device {
            port sda;
            port scl;
            port power;
            port gnd;
        }
        part def TemperatureSensor :> I2C_Device {
            attribute measurementRange: ScalarValues::String;
        }
        part def Accelerometer :> I2C_Device {
            attribute sensitivity: ScalarValues::String; // e.g. "2g", "4g"
        }
        abstract part def SPI_Device {
            port sclk;
            port mosi;
            port miso;
            port cs;
            port power;
            port gnd;
        }
        part def ExternalFlash :> SPI_Device {
            attribute capacity_MB : ScalarValues::Integer;
        }
        abstract part def UART_Device {
            port tx;
            port rx;
            port power;
            port gnd;
        }
        part def BluetoothModule :> UART_Device {
            attribute bluetoothVersion : ScalarValues::String;
        }
        part def DCMotor :> Component {}
        part def MotorDriver {
            port in1;
            port in2;
            port pwm; // Speed control
            port power;
            port gnd;
        }
        part def RGB_LED {
            port red;
            port green;
            port blue;
            port common; // Can be anode or cathode
        }
        part def Battery {
            port positive;
            port negative;
        }
        part def ChargingCircuit {
            port v_in; // From external power source like USB
            port v_sys_out; // To system
            port batt_conn_p;
            port batt_conn_n;
            port gnd;
        }
        part def USB_C_Connector {
            port vbus;
            port gnd;
            port d;
        }

        // --- AUTOSAR Architecture Definitions ---
        part def MCAL { // Microcontroller Abstraction Layer
            // Ports mirroring physical peripheral interfaces
            port dio_1; 
            port dio_2; 
            port dio_3; 
            port dio_4; 
            port dio_5;
            port dio_6; 
            port dio_7; 
            port dio_8; 
            port dio_9; 
            port dio_10; 
            port dio_11; 
            port dio_12;
            port adc_1;
            port i2c_sda;
            port i2c_scl;
            // Interface to upper layers
            port bsw_if;
        }

        part def BSW { // Basic Software (Services + ECU Abstraction)
            port mcal_if;
            port rte_if;
        }

        part def RTE { // Runtime Environment
            port bsw_if;
            port app_if;
        }

        abstract part def SoftwareComponent {
            port rte_conn; // Connection to the RTE
        }

        part def SensorSWC :> SoftwareComponent {
            // Defines runnables for sensor reading
        }

        part def LogicSWC :> SoftwareComponent {
            // Defines runnables for processing data and making decisions
        }

        part def ActuatorSWC :> SoftwareComponent {
            // Defines runnables for controlling actuators like LEDs and buzzers
        }

        part def Microcontroller :> Component {
            port power :>> a;
            port ground :>> b;
            // Physical Pins
            port gpio_1;
            port gpio_2;
            port gpio_3;
            port gpio_4;
            port gpio_5;
            port gpio_6;
            port gpio_7;
            port gpio_8;
            port gpio_9;
            port gpio_10;
            port gpio_11;
            port gpio_12;
            port adc_1;
            port i2c_sda;
            port i2c_scl;

            // --- AUTOSAR Architecture ---
            part mcal: MCAL;
            part bsw: BSW;
            part rte: RTE;

            part ApplicationLayer {
                port rte_bus;
                part sensor_logic : SensorSWC;
                part main_logic : LogicSWC;
                part actuator_control : ActuatorSWC;

                interface i_01 connect sensor_logic.rte_conn to rte_bus;
                interface i_02 connect main_logic.rte_conn to rte_bus;
                interface i_03 connect actuator_control.rte_conn to rte_bus;
            }

            // --- Internal Connections ---
            // Software layer connections
            interface i_04 connect mcal.bsw_if to bsw.mcal_if;
            interface i_05 connect bsw.rte_if to rte.bsw_if;
            interface i_06 connect rte.app_if to ApplicationLayer.rte_bus;
        }
    }
    package Components {
        private import Definitions::*;
        private import Functions::*;
        // functions
        perform activate_s1;
        perform activate_s2;
        perform turn_led1_on;
        perform turn_led1_off;
        perform turn_led2_on;
        perform turn_led2_off;
        perform runnable_ReadPotentiometer;
        perform runnable_ReadTempSensor;
        perform runnable_ProcessSensorData;
        perform runnable_UpdateDisplay;
        perform runnable_CheckAlarm;
        // attributes
        // ports
        // parts
        part box : Product {
            part pcb : CircuitBoard {
                // attributes
                // ports
                // parts
                part r1 : Resistor;
                part r2 : Resistor;
                part s1 : Microswitch;
                part s2 : Microswitch;
                part led1 : LED;
                part led2 : LED;
                part buzzer1: Buzzer;
                part pot1: Potentiometer;
                part display1: SevenSegmentDisplay;
                part v_reg: VoltageRegulator;
                part sensor1: TemperatureSensor;
                part mcu : Microcontroller;
                // Hardware to Software (Pin to MCAL) mapping
                interface i_07 connect mcu.gpio_1 to mcu.mcal.dio_1;
                interface i_08 connect mcu.gpio_2 to mcu.mcal.dio_2;
                interface i_09 connect mcu.gpio_3 to mcu.mcal.dio_3;
                interface i_10 connect mcu.gpio_4 to mcu.mcal.dio_4;
                interface i_11 connect mcu.gpio_5 to mcu.mcal.dio_5;
                interface i_12 connect mcu.gpio_6 to mcu.mcal.dio_6;
                interface i_13 connect mcu.gpio_7 to mcu.mcal.dio_7;
                interface i_14 connect mcu.gpio_8 to mcu.mcal.dio_8;
                interface i_15 connect mcu.gpio_9 to mcu.mcal.dio_9;
                interface i_16 connect mcu.gpio_10 to mcu.mcal.dio_10;
                interface i_17 connect mcu.gpio_11 to mcu.mcal.dio_11;
                interface i_18 connect mcu.gpio_12 to mcu.mcal.dio_12;
                interface i_19 connect mcu.adc_1 to mcu.mcal.adc_1;
                interface i_20 connect mcu.i2c_sda to mcu.mcal.i2c_sda;
                interface i_21 connect mcu.i2c_scl to mcu.mcal.i2c_scl;
                // power interfaces
                interface i_22 connect box.pcb.power to v_reg.vin;
                interface i_23 connect v_reg.gnd to box.pcb.ground;
                interface i_24 connect v_reg.vout to mcu.power;
                interface i_25 connect mcu.ground to box.pcb.ground;
                interface i_26 connect v_reg.vout to sensor1.power;
                interface i_27 connect sensor1.gnd to box.pcb.ground;
                // switch interfaces
                interface i_28 connect mcu.gpio_1 to s1.a;
                interface i_29 connect mcu.gpio_2 to s2.a;
                interface i_30 connect s1.b to r1.a;
                interface i_31 connect s2.b to r2.a;
                interface i_32 connect r1.b to box.pcb.ground;
                interface i_33 connect r2.b to box.pcb.ground;
                // led interfaces
                interface i_34 connect mcu.gpio_3 to led1.anode;
                interface i_35 connect led1.cathode to box.pcb.ground;
                interface i_36 connect mcu.gpio_4 to led2.anode;
                interface i_37 connect led2.cathode to box.pcb.ground;
                // buzzer interface
                interface i_38 connect mcu.gpio_5 to buzzer1.a;
                interface i_39 connect buzzer1.b to box.pcb.ground;
                // potentiometer interface
                interface i_40 connect v_reg.vout to pot1.terminal1;
                interface i_41 connect pot1.wiper to mcu.adc_1;
                interface i_42 connect pot1.terminal2 to box.pcb.ground;
                // 7-segment display interfaces
                interface i_43 connect mcu.gpio_10 to display1.seg_e;
                interface i_44 connect mcu.gpio_11 to display1.seg_f;
                interface i_45 connect mcu.gpio_12 to display1.seg_g;
                interface i_46 connect display1.common_cathode to box.pcb.ground;
                // I2C Sensor interface
                interface i_47 connect mcu.i2c_sda to sensor1.sda;
                interface i_48 connect mcu.i2c_scl to sensor1.scl;
            }
        }
    }
    package Functions {
        action activate_s1;
        action activate_s2;
        action turn_led1_on;
        action turn_led1_off;
        action turn_led2_on;
        action turn_led2_off;
        action runnable_ReadTempSensor;
        action runnable_ProcessSensorData;
        action runnable_UpdateDisplay;
        action runnable_CheckAlarm;

        // Runnables are the executable units in AUTOSAR
        action runnable_ReadPotentiometer;
        action runnable_Read;
    }
    package State_Machine {
        // state machine LedToggle {
        //     state Off {
        //         transition to On on activate_s1 { do turn_led1_on; }
        //     }
        //     state On {
        //         transition to Off on activate_s1 { do turn_led1_off; }
        //     }
        // }

        // state machine SensorMonitor {
        //     state Idle;
        //     state ReadingSensor;
        //     state SoundingAlarm;

        //     transition from Idle to ReadingSensor on activate_s2 {
        //         do read_sensor_data;
        //     }

        //     transition from ReadingSensor {
        //         when read_sensor_data.sensorValue > 100
        //         to SoundingAlarm {
        //             do sound_alarm;
        //             do turn_led2_on;
        //         }
        //         when read_sensor_data.sensorValue <= 100
        //         to Idle {
        //             do turn_led2_off;
        //         }
        //     }

        //     transition from SoundingAlarm to Idle on activate_s2;
        // }
        // // states
    }
}