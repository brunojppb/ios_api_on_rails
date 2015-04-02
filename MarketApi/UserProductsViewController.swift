//
//  UserProductsViewController.swift
//  MarketApi
//
//  Created by Bruno Paulino on 4/2/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit
import SpinKit

class UserProductsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("Section: 1")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let current_user = ApiSession.sharedInstance.current_user {
            if current_user.product_ids.isEmpty {
                return 0
            }
            else if !current_user.product_ids.isEmpty && current_user.products.isEmpty{
                return 1
            }
            else {
                return current_user.product_ids.count
            }
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let current_user = ApiSession.sharedInstance.current_user {
            if !current_user.product_ids.isEmpty && current_user.products.isEmpty {
                // Load products from server...
                current_user.loadMyProductsFromServer({ (products, error) -> Void in
                    if error == nil {
                        self.tableView.reloadData()
                    }
                    else {
                        println("Error!")
                    }
                })
                // Show empty cell with loading message
                let cell = tableView.dequeueReusableCellWithIdentifier("loading_cell", forIndexPath: indexPath) as UITableViewCell
                self.configureLoadingCell(cell, indexPath: indexPath)
                return cell
            }
            else if !current_user.products.isEmpty {
                //show user products
                let cell = tableView.dequeueReusableCellWithIdentifier("product_cell", forIndexPath: indexPath) as ProductCell
                self.configureProductCell(cell, IndexPath: indexPath, user: current_user)
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("no_product_cell", forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    
    func configureProductCell(cell: ProductCell, IndexPath: NSIndexPath, user: User) {
        let product = user.products[IndexPath.row]
        cell.title.text = product.title
        cell.price.text = "\(product.price)"
        cell.email.text = product.user.email
    }
    
    
    func configureLoadingCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        let loadingSpinner = RTSpinKitView(style: RTSpinKitViewStyle.StyleWave)
        loadingSpinner.color = UIColor.blueColor()
        let spinnerFrame = CGRectMake(cell.contentView.bounds.midX - loadingSpinner.frame.width/2, cell.contentView.bounds.midY - loadingSpinner.frame.height/2, loadingSpinner.bounds.width, loadingSpinner.bounds.height)
        loadingSpinner.frame = spinnerFrame
        cell.contentView.addSubview(loadingSpinner)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
