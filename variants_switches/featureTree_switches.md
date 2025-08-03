::: mermaid
flowchart TD
    %% Root Feature
    SteeringWheelSwitches([Steering Wheel Switches])

    %% Main Feature Categories
    SteeringWheelSwitches --> AudioControl[Audio Control]
    SteeringWheelSwitches --> CruiseControl[Cruise Control]
    SteeringWheelSwitches --> PhoneControl[Phone Control]
    SteeringWheelSwitches --> DriverAssist[Driver Assistance]
    SteeringWheelSwitches --> DisplayControl[Display/Cluster Control]
    SteeringWheelSwitches --> Illumination[Backlight Illumination]

    %% Audio Control Subfeatures
    AudioControl --> VolumeUp[Volume Up]
    AudioControl --> VolumeDown[Volume Down]
    AudioControl --> TrackNext[Track Next]
    AudioControl --> TrackPrevious[Track Previous]
    AudioControl --> Mute[Mute]

    %% Cruise Control Subfeatures
    CruiseControl --> SetSpeed[Set Speed]
    CruiseControl --> Cancel[Cancel]
    CruiseControl --> Resume[Resume]
    CruiseControl --> SpeedUp[Increase Speed]
    CruiseControl --> SlowDown[Decrease Speed]

    %% Phone Control Subfeatures
    PhoneControl --> AnswerCall[Answer Call]
    PhoneControl --> EndCall[End Call]
    PhoneControl --> VoiceCommand[Voice Command]

    %% Driver Assistance Subfeatures
    DriverAssist --> LaneAssist[Lane Assist Toggle]
    DriverAssist --> DistanceAdjust[Distance Adjust]
    DriverAssist --> AssistOnOff[Assist On/Off]

    %% Display Control Subfeatures
    DisplayControl --> MenuToggle[Menu Toggle]
    DisplayControl --> ScrollUp[Scroll Up]
    DisplayControl --> ScrollDown[Scroll Down]
    DisplayControl --> OKButton[OK/Select Button]
:::