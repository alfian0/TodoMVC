//
//  TodosPresenterTest.swift
//  TodoMVC
//
//  Created by alfian on 20/10/2016.
//  Copyright © 2016 GoJek. All rights reserved.
//

/*
import Foundation
import Quick
import Nimble
import MockFive

@testable import TodoMVC

class CreateTodoPresenterTest: QuickSpec {
    override func spec() {
        describe("Create Todo Test") {
            it("Validation of Todo description", closure: {
                let viewMock = CreateTodoViewMock()
                let serviceMock = TodoServiceMock()
                let wireframeMock = CreateToDoWireframeMock()
                
                let presenter = CreateTodoPresenter(view: viewMock, wireframe: wireframeMock, service: serviceMock)
                
                
            })
        }
    }
}

class CreateTodoViewMock : ICreateTodoView, Mock {
    var mockFiveLock: String = lock()
    
    func showAlertWithMessage(message: String) {
        return stub(identifier: "showAlertWithMessage", arguments: message) { _ in
            
        }
    }
    
    func startLoading() {
        return stub(identifier: "startLoading") { _ in
            
        }
    }
    
    func stopLoading() {
        return stub(identifier: "stopLoading") { _ in
            
        }
    }
}


class TodoServiceMock: ITodoService, Mock {
    let mockFiveLock: String = lock()
    
    func addTodo(description: String, success: NetworkSuccesCallback, failure: NetworkFailureCallback) {
        return stub(identifier: "addTodo", arguments: (description, success, failure)) { _ in
            return
        }
    }
}

class CreateToDoWireframeMock: ICreateToDoWireframe, Mock {
    var mockFiveLock: String = lock()
    
    func goBack() {
        return stub(identifier: "goBack") { _ in
        }
    }
    
}
*/