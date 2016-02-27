//
//  RmdMenuViewController.swift
//  RmdRevealViewController
//
//  Created by Nguyen Hoang Nam on 27/2/16.
//  Copyright © 2016 Alan Nguyen. All rights reserved.
//

import UIKit

class RmdMenuViewController: UITableViewController {
    struct Notifications {
        static let MainSelected = "MainSelected"
        static let RedSelected = "RedSelected"
        static let GreenSelected = "GreenSelected"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let inset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.tableView.contentInset = inset;
    }
}

extension RmdMenuViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "menu_cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "View \(indexPath.row)"
        return cell!
    }
}
extension RmdMenuViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = indexPath.item
        let center = NSNotificationCenter.defaultCenter()
        switch item {
        case 0:
            center.postNotification(NSNotification(name: Notifications.MainSelected, object: self))
        case 1:
            center.postNotification(NSNotification(name: Notifications.RedSelected, object: self))
        case 2:
            center.postNotification(NSNotification(name: Notifications.GreenSelected, object: self))
        default:
            print("Unrecognized menu index")
            return
        }
        center.postNotificationName("closeMenu", object: nil)
    }
    
}
