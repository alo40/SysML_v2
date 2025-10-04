package example_rflp {
    public import Functional::*;
    public import Logical::*;
    public import Definitions::*;
    public import SI::*;
    public import ScalarValues::*;

    package Requirements {
        // Define common types for requirements
        package Stakeholders {
            item ProductManagement;
            item SafetyEngineering;
            item UserExperience;
            item HardwareEngineering;
        }

        package Subjects {
            // The subject is the physical system itself, with measurable attributes.
            part def HandsOnWheelControlModule {
                attribute actualResponseTime :> time;
                attribute standbyCurrent :> power;
                attribute operatingTemperature :> temperature;
                attribute canBaudRate :> frequency;
                attribute selfTestStatus : Boolean;
            }
        }

        // requirement def 'RQ-01' {
        //     doc
        //     /* The fridge shall maintain an internal temperature between 1°C and 4°C (34°F and 39°F) for food preservation. */
        // }

        // requirement <'1.1'> MassRequirement{
        //     // doc /*The actual mass shall be less than the required mass*/
        //     // attribute massRequired:>ISQ::mass;
        //     // attribute massActual:>ISQ::mass;
        //     // require constraint {massActual<=massRequired}
        // }

        //  requirement def HandsOnWheelControl {}

        // // Use the defined types for clarity
        // private import Stakeholders::*;
        // private import Subjects::*;

        // requirement OperatingTemperatureRange {
            // /* The module shall operate correctly in ambient
            // * temperatures from -40 to +85 degrees Celsius. */
            // stakeholder se : SafetyEngineering;
            // subject module : HandsOnWheelControlModule;
            // attribute minTemp : TemperatureValue = -40[C];
            // attribute maxTemp : TemperatureValue = 85[C];
            // require constraint {
            //     module.operatingTemperature > minTemp and
            //     module.operatingTemperature < maxTemp
            // }
        // }
    }
    package Functional {
        use case enable_hands_on_wheel_control {
            action user_press_volume : EndUserFunction {
                action transform_request_to_message : SystemFunction {
                    action detect_user_request : ElementFunction;
                    action debounce_button_press : ElementFunction;
                    action detect_press_duration : ElementFunction;
                    action provide_haptic_feedback : ElementFunction;
                    action provide_visual_feedback : ElementFunction;
                    action evaluate_user_request : ElementFunction;
                    action decode_button_matrix : ElementFunction;
                    action validate_request_state : ElementFunction;
                    action monitor_press_status : ElementFunction;
                    action log_user_action : ElementFunction;
                    action send_control_message : ElementFunction;
                    action format_can_message : ElementFunction;
                    action verify_message_transmission : ElementFunction;
                    action receive_vcu_message : ElementFunction;
                    action provide_regulated_power : ElementFunction;
                    action provide_filtered_power : ElementFunction;
                    action monitor_system_temperature : ElementFunction;
                    action run_self_test_on_startup : ElementFunction;
                }
            }
        }
    }
    package Logical {
        abstract part def Logical_System { 
            perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message;
            abstract part def Interface {
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.detect_user_request;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.debounce_button_press;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.detect_press_duration;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.provide_haptic_feedback;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.provide_visual_feedback;
            }
            abstract part def Processing {
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.evaluate_user_request;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.decode_button_matrix;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.validate_request_state;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.monitor_press_status;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.log_user_action;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.monitor_system_temperature;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.run_self_test_on_startup;
            }
            abstract part def Communication {
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.send_control_message;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.format_can_message;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.verify_message_transmission;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.receive_vcu_message;
            }
            abstract part def Power {
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.provide_regulated_power;
                perform enable_hands_on_wheel_control.user_press_volume.transform_request_to_message.provide_filtered_power;
            }
            abstract part def Structural {
                // This block is for physical support components without active functional allocations.
            }
        }
    }
    package Physical {
        part physical_system : Logical_System {
            attribute mass = 139;
            // --- Interface Components ---
            part volume_up_button : Interface {
                attribute mass = 2;
            }
            part volume_down_button : Interface {
                attribute mass = 2;
            }
            part mute_button : Interface {
                attribute mass = 2;
            }
            part scroll_wheel_assy : Interface {
                attribute mass = wheel_body.mass + wheel_axle.mass + detent_spring.mass;
                part wheel_body : Interface {
                    attribute mass = 11;
                }
                part wheel_axle : Interface {
                    attribute mass = 1;
                }
                part detent_spring : Interface {
                    attribute mass = 1;
                }
            }
            part button_housing : Structural {
                attribute mass = 15;
            }
            part front_cover : Structural {
                attribute mass = 25;
            }
            part pcba : Structural {
                attribute mass = 81; // 30g for bare board + 51g for components
                // --- Interface Components ---
                part rotary_encoder : Interface { attribute mass = 5; }
                part status_led_green : Interface { attribute mass = 1; }
                part error_led_red : Interface { attribute mass = 1; }
                part haptic_feedback_motor : Interface { attribute mass = 8; }
                part button_backlight : Interface { attribute mass = 2; }

                // --- Processing Components ---
                part microcontroller : Processing {
                    attribute memory_flash : Real = 256*1024 [byte];
                    attribute memory_ram : Real = 32*1024 [byte];
                    attribute mass = 10;
                    //
                    part electronics : Processing;
                    part software_stack : Processing;
                }
                part external_eeprom : Processing { attribute mass = 2; }
                part main_oscillator : Processing { attribute mass = 2; }
                part jtag_debug_header : Processing { attribute mass = 3; }
                
                // --- Communication Components ---
                part can_transceiver : Communication { attribute mass = 2; }
                part can_bus_connector : Communication { attribute mass = 5; }
                part can_termination_resistor_1 : Communication { attribute mass = 1; }
                part can_termination_resistor_2 : Communication { attribute mass = 1; }
                
                // --- Power Components ---
                part main_power_regulator : Power { attribute mass = 4; }
                part input_filter_capacitor : Power { attribute mass = 1; }
                part output_smoothing_capacitor : Power { attribute mass = 1; }
                part main_fuse : Power { attribute mass = 1; }
                part reverse_protection_diode : Power { attribute mass = 1; }
            }
        }
    }
    package Definitions {
        action def Function {
            port input;
            port output;
        }
        action def EndUserFunction :> Function;
        action def SystemFunction :> Function;
        action def ElementFunction :> Function;
    }
}