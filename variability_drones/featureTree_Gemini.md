::: mermaid
classDiagram
%% Packages
class Variability
class DroneProductLine
class DeliveryDroneSystemX42Model
Variability --> DroneProductLine
Variability --> DeliveryDroneSystemX42Model

%% Battery hierarchy
class Battery
class StandardBattery
class PowerBattery
Battery <|-- StandardBattery
Battery <|-- PowerBattery
DroneProductLine --> Battery

%% Camera hierarchy
class Camera
class StandardCamera
class HighResCamera
class ThermalCamera
Camera <|-- StandardCamera
Camera <|-- HighResCamera
Camera <|-- ThermalCamera
DroneProductLine --> Camera

%% Drone and DroneSystem
class DroneSystem {
  +drones[*]: Drone
}
class Drone {
  +battery: Battery (variation)
  +engines[4..8] (variation)
  +camera: Camera (variation)
}
DroneSystem --> "drones[*]" Drone
Drone --> Battery
Drone --> Camera

%% Engine Variants
class fourEngines {
  +[4]
}
class sixEngines {
  +[6]
}
class eightEngines {
  +[8]
}
Drone --> fourEngines
Drone --> sixEngines
Drone --> eightEngines

%% DeliveryDroneSystemX42Model
class DeliveryDroneSystemX42 {
  +drones[*]:
  +battery = powerBattery
  +camera = standard_camera
  +engines = sixEngines
}
DeliveryDroneSystemX42 --|> DroneSystem

%% Imports
DeliveryDroneSystemX42Model ..> DroneProductLine : private import
:::