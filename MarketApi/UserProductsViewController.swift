//
//  UserProductsViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/31/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UserProductsViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ApiSession.sharedInstance.current_user == nil {
            self.performSegueWithIdentifier("login_screen", sender: self)
        }
    }
    
}
