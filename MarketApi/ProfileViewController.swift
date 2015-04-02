//
//  ProfileViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 4/1/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    @IBOutlet weak var user_email: UILabel!
    @IBOutlet weak var user_auth_token: UILabel!
    @IBOutlet weak var user_number_of_products: UILabel!
    @IBOutlet weak var email_textfield: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUserProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUserProfile() {
        if let current_user = ApiSession.sharedInstance.current_user {
            self.user_email.text = current_user.email
            self.user_auth_token.text = current_user.auth_token
            self.user_number_of_products.text = "\(current_user.product_ids.count)"
        }
    }

}
