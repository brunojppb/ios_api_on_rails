//
//  NewProductViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 4/2/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit

class NewProductViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var title_textfield: UITextField!
    @IBOutlet weak var price_textfield: UITextField!
    @IBOutlet weak var quantity_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func done(sender: AnyObject) {
        let title = title_textfield.text
        let price = (price_textfield.text as NSString).doubleValue
        let quanitity = quantity_label.text!.toInt()!
        println("title: \(title)\nPrice: \(price)\nquantity: \(quanitity)")
        let newProduct = Product(id: nil, title: title, price: price, user: ApiSession.sharedInstance.current_user!, quantity: quanitity)
        newProduct.save { (product, error) -> Void in
            if error == nil && product != nil{
                ApiSession.sharedInstance.current_user!.product_ids.append(product!.id!)
                ApiSession.sharedInstance.current_user!.products.append(product!)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func changeQuantity(sender: UIStepper) {
        self.quantity_label.text = "\(sender.value)"
    }
}
