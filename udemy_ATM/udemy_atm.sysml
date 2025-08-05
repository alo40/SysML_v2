package 'udemy ATM' {
    package 'Parts Tree' {
        public import ScalarValues::*;
        part def <ATM> 'Automated Teller Machine' {
            attribute serialNumber : String;
            part userInterface : UserInterface;
            action provideCashWithdraw;
        }
        part def UserInterface;
        part atm1 : ATM;
    }
}

