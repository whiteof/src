//
//  ListViewController.swift
//  ServerRemoteControl
//
//  Created by Victor Yurkin on 3/25/16.
//  Copyright © 2016 WCMC. All rights reserved.
//

import UIKit
import Foundation

class ListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if(indexPath.row == 0) {
            cell.textLabel?.text = "lamp-dev01.med.cornell.edu"
            cell.detailTextLabel?.text = "IP: 140.251.7.146"
        }
        if(indexPath.row == 1) {
            cell.textLabel?.text = "lamp-prd01.med.cornell.edu"
            cell.detailTextLabel?.text = "IP: 140.251.6.41"
            cell.imageView?.image = UIImage(named: "Icon - Server")
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender is UITableViewCell {
            let nextScene = segue.destinationViewController as! DetailsViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
                nextScene.serverIP = currentCell.detailTextLabel!.text
            }
        }
    }
    
}
