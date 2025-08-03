package Drone_FeatureModel{
        private import FeatureModeling::*;

        #feature def droneProductLineFeatures {
            #feature missionTime {
                attribute :>> bindingTime = LifeCycleKind::Production;
            }
            #feature standardMission :> missionTime;
            #feature longMission :> missionTime;
        }
    }
library package FeatureModeling {
    enum def LifeCycleKind :> ScalarValues::Natural {
        doc /* Definition of features binding times.
                * The numbers provides an order of the life cycles. */
        enum Development = 1;
        enum Production = 2;
        enum Operation = 3;
    }
    occurrence def Feature {
        doc /* A Feature is a characteristic of a product in a product line 
                * that distinguishes it from other products in the product line. */
        attribute bindingTime : LifeCycleKind default LifeCycleKind::Development {
            doc /* The binding time of the feature with default Development. */
        } 
    }
}