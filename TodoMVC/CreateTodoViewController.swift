//
//  CreateTodoViewController.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import UIKit
import Alamofire

class CreateTodoViewController: UIViewController {
    @IBOutlet weak var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Todo"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateTodoViewController.touchDone))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func touchDone() {
        addTodo()
    }
    
    func addTodo() {
        let todoText = textField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        guard let text = todoText where text.characters.count > 0 else {
            showAlertWithMessage("Please enter the todo description")
            return
        }
        startLoading()
        let url = BASE_URL + "/todos/create"
        Alamofire.request(.POST, url, parameters: ["description" : text], headers: AuthManager.sharedManager.authHeaders).responseString {[weak self] response in
            self?.stopLoading()
            guard let jsonString = response.result.value else {
                let message = response.result.error?.localizedDescription ?? ""
                self?.showAlertWithMessage("Unable to add todo: \(message)")
                return
            }
            let createResponse = CreateTodoResponse(JSONString: jsonString)
            guard let _ = createResponse?.todo where createResponse?.error == nil else {
                self?.showAlertWithMessage(createResponse?.error?.nsError.localizedDescription ?? "Unable to create todo")
                return
            }
            self?.navigationController?.popViewControllerAnimated(true)
        }

    }
}

// 1. Create Wireframe to separate navigation
//func goBack() {
//    let navigationController = UIApplication.sharedApplication().delegate?.window??.rootViewController as? UINavigationController
//        navigationController?.popViewControllerAnimated(true)
//}
// 2. Create IView
//      - showAlertWithMessage(message: String)
//      - startLoading()
//      - stopLoading()
// 3. Create IService (to separate Network Service)
//      - ITodos (createTodos)
// 4. Add pod
//      -pod 'MockFive'
//      - pod 'Quick', '~> 0.9.3'
//      - pod 'Nimble', '~> 4.1.0'
// 5. Mock Network call for ansyncrounous
//    it("Should call network addTodo with success if valid todo", closure: {
//        serviceMock.registerStub("addTodo", returns: { args -> Void in
//            let (_, success, _) = args[0] as! (String, () -> Void, (String) -> Void)
//            success()
//            
//        })
//        
//        presenter.addTodo("Valid todo")
//        
//        expect(viewMock.invocations).to(contain("startLoading()"))
//        expect(viewMock.invocations).to(contain("stopLoading()"))
//        expect(wireframeMock.invocations).to(contain("goBack()"))
//    })



// 1. UITest secure textField
//    UIPasteboard.generalPasteboard().string = "password"
//    let passwordSecureTextField = app.secureTextFields["Password"]
//    passwordSecureTextField.pressForDuration(1.1)
//    app.menuItems["Paste"].tap()
// 2. SBT Tunnel
//    1) Podfile we need add target
//    target 'TodoMVCUITests' do
//    use_frameworks!
//    pod 'SBTUITestTunnel/Client', :git => 'https://github.com/venkateshcm/SBTUITestTunnel'
//    end
//    2) Add below pod to TodoMVC target
//    pod 'SBTUITestTunnel/Server', :git => 'https://github.com/venkateshcm/SBTUITestTunnel
//    3) pod install
//    4) Add Build Phase run script with
//    "${SRCROOT}/Pods/Target Support Files/Pods-TodoMVCUITests/Pods-TodoMVCUITests-frameworks.sh"
//    5) In AppDelegate call SBTUITestTunnelServer.takeOff()
//    6) create app using
//    app = SBTUITunneledApplication()
//    app.launchTunnel()
//    7) create request matcher
//    let matcher = SBTRequestMatch.URL("/login",method:"POST")
//    app.stubRequestsMatching(matcher, returnJsonNamed:"login_response.json", returnCode:200 ,responseTime:SBTUITunnelStubsDownloadSpeed3G)
//    8) Setup expectation fulling
//    let expectation = expectationWithDescription("Query timed out.");
//    app.waitForMonitoredRequestsMatching(matcher,timeout:1, completionBlock:{ result in
//        expectation.fulfill();
//    })
//    9) Wait for expectation fullfill before asserting
//    waitForExpectationsWithTimeout(10,handler:nil)
//    10) Run the test