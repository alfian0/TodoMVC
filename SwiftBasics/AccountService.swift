//
//  AccountService.swift
//  iOSTrainingBasics
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IAccountService {
    func getCustomerCurrentBalance() -> Int
}


class AccountService: IAccountService {
    func getCustomerCurrentBalance() -> Int {
        fatalError("This method is not implemented")
    }
}
