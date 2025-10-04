package Context {
    part def Generic {
        part input;
        part illumination;
        part communication;
        part processing;
        part supply;
        port connector;
    }
    part left : Generic {
        part button :>> input;
        part rocker :>> input;
        part scroll :>> input;
        part rotary :>> input;
        part backlight :>> illumination;
        part lin :>> communication;
        part can :>> communication;
        part mcu :>> processing;
        part U12V :>> supply;
        part U3V3 :>> supply;
        port c12pin :>> connector;
    }
    part right : Generic {
        part button :>> input;
        part rocker :>> input;
        part scroll :>> input;
        part rotary :>> input;
        port c12pin :>> connector;
        :>> supply;
    }
    interface connect right.c12pin to left.c12pin;
}