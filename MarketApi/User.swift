//
//  User.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/31/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import Foundation

class User : Printable {
    
    var id : Int
    var email : String
    var password : String
    var auth_token : String?
    
    required init(id: Int, email: String, password: String, auth_token: String?) {
        self.id = id
        self.email = email
        self.auth_token = auth_token
        self.password = password
    }
    
    class func endpointForID(id: Int) -> String {
        return "\(base_api_url)/\(id)"
    }
    
    class func endpointForUsers() -> String {
        return "\(base_api_url)/users"
    }
    
    var description : String {
        return "id: \(id)\nEmail: \(email)\nauth_token: \(auth_token!)"
    }
    
}
