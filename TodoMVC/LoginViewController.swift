//
//  LoginViewController.swift
//  TodoMVC
//
//  Created by Harshad on 10/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(LoginViewController.touchDone))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        emailField?.becomeFirstResponder()
    }
    
    func touchDone() {
        
    }
    
    func validateAndLogin() {
        var errorMessage: String?
        guard let email = emailField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) else {
            showAlertWithMessage("All fields are mandatory")
            return
        }
        guard let password = passwordField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) else {
            showAlertWithMessage("All fields are mandatory")
            return
        }
        
        if email.characters.count == 0 {
            errorMessage = "Enter a valid email address"
        }
        if password.characters.count < 6 {
            errorMessage = "Please enter a password (min 6 characters)"
        }
        
        if errorMessage != nil {
            showAlertWithMessage(errorMessage!)
        } else {
            login(email, password: password)
        }
        
    }
    
    func login(email: String, password: String) {
        startLoading()
        let url = BASE_URL + "/login"
        Alamofire.request(.POST, url, parameters: ["username" : email, "password" : password], headers: [:]).responseString {[weak self] response in
            self?.stopLoading()
            guard let jsonString = response.result.value else {
                self?.showAlertWithMessage("Unable to login")
                return
            }
            let signupResponse = SignUpResponse(JSONString: jsonString)
            if let token = signupResponse?.token {
                AuthManager.sharedManager.saveToken(token)
                self?.showTodoList()
            } else {
                self?.showAlertWithMessage(signupResponse?.error?.nsError.localizedDescription ?? "Unable to login")
            }
        }
    }
    
    func showTodoList() {
        let listController = TodoListViewController(nibName: "TodoListViewController", bundle: nil)
        navigationController?.setViewControllers([listController], animated: true)
    }
    
    @IBAction func emailFieldDone(field: UITextField) {
        passwordField?.becomeFirstResponder()
    }
    
    @IBAction func passwordFieldDone(field: UITextField) {
        validateAndLogin()
    }
}
