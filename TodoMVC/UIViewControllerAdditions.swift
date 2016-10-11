//
//  UIViewControllerAdditions.swift
//  TodoMVC
//
//  Created by Harshad on 11/10/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func startLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func stopLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
}