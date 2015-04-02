//
//  User.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/31/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class User : Printable {
    
    var id : Int
    var email : String
    var password : String
    var auth_token : String?
    var products : [Product]
    var product_ids : [Int]
    
    required init(id: Int, email: String, password: String, auth_token: String?, product_ids: [Int] = [Int](), products: [Product] = [Product]()) {
        self.id = id
        self.email = email
        self.auth_token = auth_token
        self.password = password
        self.product_ids = product_ids
        self.products = products
    }
    
    func loadMyProductsFromServer(completionHandler: (products: [Product]?, error: NSError?)->Void) {
        var params = "?"
        for id in self.product_ids {
            params += "product_ids[]=\(id)&"
        }
        Alamofire.request(.GET, "\(base_api_url)/products/\(params)", encoding: .JSON).response { (request, response, data, error) -> Void in
            if error == nil {
                let json = JSON(data: data as NSData)
                if let errors = json["errors"].string {
                    completionHandler(products: nil, error: NSError())
                }
                else {
                    var products = [Product]()
                    let json_products = json["products"].arrayValue
                    for prod in json_products {
                        let product_id = prod["id"].int!
                        let product_title = prod["title"].string!
                        let product_price = prod["price"].double!
                        let product = Product(id: product_id, title: product_title, price: product_price, user: self)
                        products.append(product)
                    }
                    self.products = products
                    completionHandler(products: products, error: nil)
                }
            }
            else {
                completionHandler(products: nil, error: error)
            }
        }
    }
    
    class func endpointForID(id: Int) -> String {
        return "\(base_api_url)/\(id)"
    }
    
    class func endpointForUsers() -> String {
        return "\(base_api_url)/users"
    }
    
    var description : String {
        return "id: \(id)\nEmail: \(email)\nauth_token: \(auth_token!)\nproduct_ids: \(product_ids)"
    }
    
    //MARK: ApiModelProtocol
    func save<User>(completionBlock: (model: User?, error: NSError?) -> Void) -> Void{
    }
    
    func update<User>(completionBlock: (model: User?, error: NSError?) -> Void) {
    }
    
    func delete(completionBlock: (error: NSError?) -> Void) {
    }
    
    class func findByID<User>(id: Int, completionBlock: (model: User?, error: NSError?) -> Void) {
    }
    
    class func search<User>(params: [String : AnyObject],
        completionBlock: (result: [User]?, error: NSError?) -> Void) {
        
    }
    
}
