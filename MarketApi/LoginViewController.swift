//
//  ViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/30/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Login(sender: AnyObject) {
        let email = self.email_text_field.text
        let password = self.password_text_field.text
        ApiSession.sharedInstance.logInUser(email, password: password) { (user, error) -> Void in
            if user == nil && error == nil {
                //Invalid credentials
                self.showAlertMessage("Invalid Email/Password")
            }
            else if let loggedUser = user {
                //User was successfully logged in
                //redirect user to main screen
                println("User: \(loggedUser)")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}



































