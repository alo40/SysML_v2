package syside_typeChecking {
    package 'Non-Conforming Types 1' {
        private import ScalarValues::*;

        attribute a : Boolean = true;
        attribute b : String = a;
    }

    package 'Non-Conforming Types 2' {
        private import ScalarValues::*;

        attribute a : Positive = 42;
        attribute b : Positive = -42;
    }

    package 'Conforming Types 1' {
        private import ScalarValues::*;

        attribute a : Positive = 42 + 0;
        attribute b : Positive = a;
    }

    package Collect {
        private import ControlFunctions::collect;
        private import ScalarValues::Positive;

        attribute def A {
            attribute value : Positive;
        }
        attribute def B;

        attribute a : A [*] = (1..10)->collect { in attribute x : Positive; A(x) };
        attribute b : B [*] = (1..10)->collect { in attribute x : Positive; A(x) };
    }

    package Select {
        private import ControlFunctions::select;
        private import ScalarValues::*;

        attribute a : Positive [*] = ((-1)..10)->select { in attribute x : Integer; x istype Positive };
        attribute b : Positive [*] = ((-1)..10)->select { true };
    }

    package Arrays {
        private import Collections::Array;
        private import ScalarValues::*;ß

        attribute array : Array {
            :>> elements : Positive;
        }

        attribute a : Positive = array->CollectionFunctions::'#'(1);
        attribute b : Positive = array->CollectionFunctions::'array#'(1);
    }
}