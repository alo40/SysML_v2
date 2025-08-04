package Demo {
  package Fridge_Diagnostic {
    private import Fridge_Signals::*;
    private import Fridge_Actions::*;

    state def DiagnosticStates {
      // States
      state green  {
        doc /* The temperature in the fridge is as expected. */
      }
      state yellow {
        doc /* The temperature in the fridge is too high, but not critical yet. */
      }
      state red {
        doc /* The temperature in the fridge is critical, the food is going to get bad. */
      }

      // Init
      entry;
      then green;
      do readSensors;

      // Transitions
      //    From Green
      transition green_to_yellow first green
        accept when readSensors.temp >= YellowThreshold and readSensors.temp < RedThreshold
        then yellow;
      transition green_to_red first green
        accept when readSensors.temp >= RedThreshold
        then red;
      //    From Yellow
      transition yellow_to_green first yellow
        accept when readSensors.temp < YellowThreshold
        then green;
      transition yellow_to_red first yellow
        accept when readSensors.temp >= RedThreshold
        then red;
      //    From Red
      transition red_to_green first red
        accept when readSensors.temp < YellowThreshold
        then green;
    }
  }

  package Fridge_Signals {
    // Thresholds
    attribute YellowThreshold = 6;
    attribute RedThreshold = 9;
  }

  package Fridge_Actions {
    private import ScalarValues::Integer;

    action readSensors {
      out temp : Integer;
    }
  }
}