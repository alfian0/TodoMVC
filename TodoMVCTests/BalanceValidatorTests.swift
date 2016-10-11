//
//  BalanceValidatorTests.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import XCTest
import MockFive

@testable import TodoMVC

struct MockAccountService: IAccountService, Mock {
    let mockFiveLock = lock()
    func getCustomerCurrentBalance() -> Int {
        return stub(identifier: "getCustomerBalance") { _ -> Int in
            return 1000
        }
    }
}

class BalanceValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReturnsTrueIfBalanceIsSufficient() {
        let accountServiceMock = MockAccountService()
        accountServiceMock.registerStub("getCustomerBalance") { _ -> Int in
            return 100
        }
        let balanceValidator = BalanceValidator(accountService: accountServiceMock)
        let shouldHaveSufficientBalance = balanceValidator.hasSufficientBalance(99)
        XCTAssertTrue(shouldHaveSufficientBalance, "Balance validator says insufficient balance even if balance is sufficient")
        
    }

    func testReturnsFalseIfBalanceIsInsufficient() {
        let accountServiceMock = MockAccountService()
        accountServiceMock.registerStub("getCustomerBalance") { _ -> Int in
            return 98
        }
        let balanceValidator = BalanceValidator(accountService: accountServiceMock)
        let shouldHaveSufficientBalance = balanceValidator.hasSufficientBalance(99)
        XCTAssertTrue(!shouldHaveSufficientBalance, "Balance validator says insufficient balance even if balance is sufficient")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
