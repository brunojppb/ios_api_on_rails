//
//  ViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/30/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit
import SpinKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    
    var loadingSpinner : RTSpinKitView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingSpinner = RTSpinKitView(style: RTSpinKitViewStyle.StyleThreeBounce)
        self.loadingSpinner.color = UIColor.whiteColor()
        let spinnerFrame = CGRectMake(self.view.bounds.midX - loadingSpinner.frame.width/2, self.view.bounds.midY - loadingSpinner.frame.height/2, loadingSpinner.bounds.width, loadingSpinner.bounds.height)
        self.loadingSpinner.frame = spinnerFrame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Login(sender: AnyObject) {
        let email = self.email_text_field.text
        let password = self.password_text_field.text
        self.addSpinner()
        ApiSession.sharedInstance.logInUser(email, password: password) { (user, error) -> Void in
            if user == nil && error == nil {
                //Invalid credentials
                self.removeSpinner()
                self.showAlertMessage("Invalid Email/Password")
            }
            else if let loggedUser = user {
                //User was successfully logged in
                //redirect user to main screen
                println("User: \(loggedUser)")
                self.removeSpinner()
                
                let appDelegate = UIApplication.sharedApplication().delegate
                appDelegate?.window!?.rootViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as UITabBarController
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
    
    func addSpinner() {
        self.view.addSubview(self.loadingSpinner)
    }
    
    func removeSpinner() {
        self.loadingSpinner.removeFromSuperview()
    }
}



































