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
    var quantity : Int
    var user : User
    
    required init(id: Int?, title: String, price: Double, quantity: Int, user: User) {
        self.id = id
        self.title = title
        self.price = price
        self.quantity = quantity
        self.user = user
    }
    
    func save(completionHandler: (product: Product?, error: NSError?) -> Void) {
        Alamofire.request(.POST, Product.endpointForProducts(), parameters: self.toJSON(), encoding: .JSON)
                    .response { (request, response, data, error) -> Void in
                        if error == nil {
                            let json = JSON(data: data as NSData)
                        }
        }
    }
    
    func toJSON() -> [String : AnyObject] {
        var json = [String : AnyObject]()
        json = [
            "product" : [
                "title": self.title,
                "price": self.price,
                "quantity": self.quantity,
                "user": self.user.id
            ]
        ]
        
        return json
    }
    
    class func endpointForProducts() -> String {
        return "\(base_api_url)/products"
    }
    
}
