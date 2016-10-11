//
//  AuthManager.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation


class AuthManager {
    static let sharedManager = AuthManager()
    private (set) var token: String = ""
    
    func saveToken(token: String) {
        self.token = token
    }
    
    var authHeaders: [String : String] {
        return ["Authorization" : "Bearer " + token]
    }
    
    var canAuthorize: Bool {
        return token.characters.count > 0
    }
}