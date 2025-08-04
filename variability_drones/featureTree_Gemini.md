::: mermaid
%%{init: { 'flowchart': { 'defaultRenderer': 'elk', 'elk': { 'edgeRouting': 'ORTHOGONAL' } } } }%%
flowchart TD
    %% Root Feature
    subgraph "Feature Model"
        Drone([Drone])

        %% Main Feature Categories
        Drone --> Battery
        Drone --> Engines
        Drone --> Camera

        %% Battery Options
        Battery --> StandardBattery[Standard Battery]
        Battery --> PowerBattery[Power Battery]

        %% Engine Options
        Engines --> FourEngines[4 Engines]
        Engines --> SixEngines[6 Engines]
        Engines --> EightEngines[8 Engines]

        %% Camera Options
        Camera --> StandardCamera[Standard Camera]
        Camera --> HighResCamera[High-Res Camera]
        Camera --> ThermalCamera[Thermal Camera]
    end

    %% Specific Configuration
    subgraph "Product Configuration"
        DeliveryDrone("DeliveryDroneSystem X42")
        SurveillanceDrone("SurveillanceDroneSystem S88")
    end

    %% Connect configuration to selected features
    DeliveryDrone --> SixEngines
    DeliveryDrone --> PowerBattery
    DeliveryDrone --> StandardCamera

    SurveillanceDrone --> EightEngines
    SurveillanceDrone --> PowerBattery
    SurveillanceDrone --> HighResCamera
:::