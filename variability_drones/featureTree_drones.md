::: mermaid
graph TD
    Drone(DRONE)
    
    %% Main Features
    Drone --> Navigation
    Drone --> Propulsion
    Drone --> Payload
    Drone --> Communication
    Drone --> ControlSystem
    Drone --> PowerSource

    %% Navigation Subfeatures
    Navigation --> GPS
    Navigation --> IMU
    Navigation --> ObstacleAvoidance

    %% Propulsion Subfeatures
    Propulsion --> QuadRotor
    Propulsion --> FixedWing

    %% Payload Subfeatures
    Payload --> Camera
    Payload --> PackageHolder
    Payload --> RacingModule

    %% Communication Subfeatures
    Communication --> RF
    Communication --> 5G
    Communication --> Satellite

    %% Control System Subfeatures
    ControlSystem --> Manual
    ControlSystem --> Autonomous

    %% Power Source Subfeatures
    PowerSource --> Battery
    PowerSource --> Solar

    %% Variants
    Drone --> SurveillanceDrone(Surveillance Drone)
    Drone --> DeliveryDrone(Delivery Drone)
    Drone --> RacingDrone(Racing Drone)

    %% Surveillance Drone Features
    SurveillanceDrone --> Camera
    SurveillanceDrone --> GPS
    SurveillanceDrone --> ObstacleAvoidance
    SurveillanceDrone --> RF
    SurveillanceDrone --> Autonomous
    SurveillanceDrone --> Battery

    %% Delivery Drone Features
    DeliveryDrone --> PackageHolder
    DeliveryDrone --> GPS
    DeliveryDrone --> ObstacleAvoidance
    DeliveryDrone --> 5G
    DeliveryDrone --> Autonomous
    DeliveryDrone --> Battery

    %% Racing Drone Features
    RacingDrone --> RacingModule
    RacingDrone --> IMU
    RacingDrone --> Manual
    RacingDrone --> RF
    RacingDrone --> QuadRotor
    RacingDrone --> Battery
:::