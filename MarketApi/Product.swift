//
//  Product.swift
//  MarketApi
//
//  Created by Bruno Paulino on 3/31/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Product {
    
    var id : Int?
    var title : String
    var price : Double
    var user : User
    var quantity: Int
    
    required init(id: Int?, title: String, price: Double, user: User, quantity: Int = 1) {
        self.id = id
        self.title = title
        self.price = price
        self.user = user
        self.quantity = quantity
    }
    
    func toJSON() -> [String : AnyObject] {
        var json = [String : AnyObject]()
        json = [
            "product" : [
                "title": self.title,
                "price": self.price,
                "quantity": self.quantity,
                "user_id": self.user.id
            ]
        ]
        
        return json
    }
    
    //MARK: ApiModelProtocol
    func save(completionBlock: (product: Product?, error: NSError?) -> Void) -> Void{
        let url = "\(base_api_url)/users/\(ApiSession.sharedInstance.current_user!.id)/products"
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": ApiSession.sharedInstance.current_user!.auth_token!]

        Alamofire.request(.POST, url, parameters: self.toJSON(), encoding: .JSON)
            .response { (request, response, data, error) -> Void in
                if error == nil {
                    let json = JSON(data: data as NSData)
                    if let errors = json["errors"].string {
                        completionBlock(product: nil, error: nil)
                    }
                    else {
                        let id = json["product"]["id"].int!
                        let title = json["product"]["title"].string!
                        let price = json["product"]["price"].double!
                        let quantity = json["product"]["quantity"].int!
                        let product = Product(id: id, title: title, price: price, user: ApiSession.sharedInstance.current_user!, quantity: quantity)
                        completionBlock(product: product, error: nil)
                    }
                }
                else {
                    completionBlock(product: nil, error: error)
                }
        }
    }
    
    func update<Product>(completionBlock: (model: Product?, error: NSError?) -> Void) {
    }
    
    func delete(completionBlock: (error: NSError?) -> Void) {
    }
    
    class func findByID<Product>(id: Int, completionBlock: (model: Product?, error: NSError?) -> Void) {
    }
    
    class func search<Product>(params: [String : AnyObject],
        completionBlock: (result: [Product]?, error: NSError?) -> Void) {
            
    }
    
}
