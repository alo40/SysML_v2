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
            // --- Interface Components ---
            part volume_up_button : Interface;
            part volume_down_button : Interface;
            part mute_button : Interface;
            part scroll_wheel_assy : Interface {
                part wheel_body : Interface;
                part wheel_axle : Interface;
                part detent_spring : Interface;
            }
            part button_housing : Structural;
            part front_cover : Structural;
            part pcba : Structural {
                // --- Interface Components ---
                part rotary_encoder : Interface;
                part status_led_green : Interface;
                part error_led_red : Interface;
                part haptic_feedback_motor : Interface;
                part button_backlight : Interface;

                // --- Processing Components ---
                part microcontroller : Processing {
                    part electronics : Processing;
                    part software_stack : Processing;
                }
                part external_eeprom : Processing;
                part main_oscillator : Processing;
                part jtag_debug_header : Processing;
                
                // --- Communication Components ---
                part can_transceiver : Communication;
                part can_bus_connector : Communication;
                part can_termination_resistor_1 : Communication;
                part can_termination_resistor_2 : Communication;
                
                // --- Power Components ---
                part main_power_regulator : Power;
                part input_filter_capacitor : Power;
                part output_smoothing_capacitor : Power;
                part main_fuse : Power;
                part reverse_protection_diode : Power;
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