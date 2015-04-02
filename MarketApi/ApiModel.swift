//
//  ApiModel.swift
//  MarketApi
//
//  Created by Bruno Paulino on 4/2/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

protocol ApiModel {
    func save<T>(completionBlock: (model: T?, error: NSError?)-> Void) -> Void
    func update<T>(completionBlock: (model: T?, error: NSError?)-> Void)
    func delete(completionBlock: (error: NSError?)-> Void)
    class func findByID<T>(id: Int, completionBlock: (model: T?, error: NSError?)-> Void)
    class func search<T>(params: [String: AnyObject], completionBlock: (result: [T]?, error: NSError?)-> Void)
}
