//
//  BalanceValidator.swift
//  iOSTrainingBasics
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation


class BalanceValidator {
    let accountService: IAccountService
    
    
    init(accountService: IAccountService) {
        self.accountService = accountService
    }
    
    
    func hasSufficientBalance(amountForWithdrawal: Int) -> Bool {
        return accountService.getCustomerCurrentBalance() >= amountForWithdrawal
    }
}
