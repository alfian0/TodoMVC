//
//  TodoListViewController.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import UIKit
import Alamofire

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView?
    private let cellIdentifier = "TodoCellIdentifier"
    private var todos: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo List"
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(TodoListViewController.touchAdd))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTodos()
    }
    
    func refreshTodos() {
        startLoading()
        let url = BASE_URL + "/todos"
        Alamofire.request(.GET, url, headers: AuthManager.sharedManager.authHeaders).responseString {[weak self] response in
            self?.stopLoading()
            guard let jsonString = response.result.value else {
                let errorMessage = response.result.error?.localizedDescription ?? ""
                self?.showAlertWithMessage("Could not get todos: \(errorMessage)")
                return
            }
            let todosResponse = GetTodosResponse(JSONString: jsonString)
            guard let fetchedTodos = todosResponse?.todos where todosResponse?.error == nil else {
                self?.showAlertWithMessage(todosResponse?.error?.nsError.localizedDescription ?? "Failed to fetch todos")
                return
            }
            self?.todos = fetchedTodos
            self?.tableView?.reloadData()
        }
    }
    
    func touchAdd() {
        let addController = CreateTodoViewController(nibName: "CreateTodoViewController", bundle: nil)
        navigationController?.pushViewController(addController, animated: true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = todos[indexPath.row].description
        return cell
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        todos.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: Show the edit screen
    }
}
