package 'ATM Requirements' {
    private import ScalarValues::*;
    private import ISQ::*;

    type def TimeValue : Real;
    type def Percentage : Real;

    part def ATM;
    part def UserInterface;
    part def Computer;
    part def CashManagement;
    part def Dispenser;
    
    constraint def MaxTimeConstant {
        in actualTime : TimeValue;
        in threshold : Percentage;
        in objective : TimeValue;
        actualTime <= threshold
    }

    constraint def AccuracyConstraint {
        in actualAccuracy : Percentage;
        in threshold : Percentage;
        in objective : Percentage;
        actualAccuracy >= threshold
    }

    requirement def WithdrawCashParent {
        subject atm : ATM;
        doc /* The ATM shall perform cash withdraws at least as fast as human tellers on average */

        require prompt : PromptWithdrawalAmount;
    }
}
