//
//  Session.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/31/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiSession {
    
    // Singleton thread-safe implementation
    // Link: http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    class var sharedInstance : ApiSession {
        struct Static {
            static var instance : ApiSession?
            static var token : dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ApiSession()
        }
        
        return Static.instance!

    }
    
    var _current_user : User?
    
    var current_user : User? {
        get {
            if _current_user == nil {
                let userInfo = NSUserDefaults.standardUserDefaults().objectForKey("user") as [String : AnyObject]?
                if let user = userInfo {
                    let id = user["id"]! as Int
                    let email = user["email"]! as String
                    let password = user["password"] as String
                    let auth_token = user["auth_token"] as String
                    let product_ids = user["product_ids"] as [Int]
                    let loggedUser = User(id: id, email: email, password: password, auth_token: auth_token, product_ids: product_ids)
                    _current_user = loggedUser
                }
            }
            
            return _current_user
        }
        
        set {
            _current_user = newValue
        }
    }
    
    func logInUser(email: String, password: String, completionHandler: (user: User?, error: NSError?) -> Void) {
        let session : [String : AnyObject] = [
            "session" : [
                "email" : email,
                "password": password
            ]
        ]
        
        Alamofire.request(.POST, "\(base_api_url)/sessions", parameters: session, encoding: .JSON)
                .response { (request, response, data, error) -> Void in
            if error == nil {
                let json = JSON(data: data as NSData)
                if let errors = json["errors"].string {
                    completionHandler(user: nil, error: nil)
                }
                else if var user = json["user"].dictionaryObject {
                    let id = user["id"] as Int
                    let email = user["email"] as String
                    let auth_token = user["auth_token"] as String
                    let product_ids = user["product_ids"] as [Int]
                    let loggedUser = User(id: id, email: email, password: password, auth_token: auth_token, product_ids: product_ids)
                    self.current_user = loggedUser
                    // save the logged in user with password
                    // We need the password to update the user's auth_token
                    user["password"] = password
                    NSUserDefaults.standardUserDefaults().setObject(user, forKey: "user")
                    completionHandler(user: self.current_user, error: nil)
                }
            }
            else {
                completionHandler(user: nil, error: error)
            }
        }
        
    }
}
