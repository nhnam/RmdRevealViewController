//
//  RmdNavigationController.swift
//  RmdRevealViewController
//
//  Created by Nguyen Hoang Nam on 27/2/16.
//  Copyright © 2016 Alan Nguyen. All rights reserved.
//

import UIKit

class RmdNavigationController: UINavigationController {
    
    private var mainSelectedObserver: NSObjectProtocol?
    private var redSelectedObserver: NSObjectProtocol?
    private var greenSelectedObserver: NSObjectProtocol?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    private func addObservers() {
        let center = NSNotificationCenter.defaultCenter()
        
        mainSelectedObserver = center.addObserverForName(RmdMenuViewController.Notifications.MainSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let mvc = RmdViewController()
            mvc.view.backgroundColor = UIColor.redColor()
            mvc.title = "Blue View"
            self.setViewControllers([mvc], animated: false)
        }
        
        redSelectedObserver = center.addObserverForName(RmdMenuViewController.Notifications.RedSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let mvc = RmdViewController()
            mvc.view.backgroundColor = UIColor.blueColor()
            mvc.title = "Red View"
            self.setViewControllers([mvc], animated: false)
        }
        
        greenSelectedObserver = center.addObserverForName(RmdMenuViewController.Notifications.GreenSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let mvc = RmdViewController()
            mvc.view.backgroundColor = UIColor.greenColor()
            mvc.title = "Green View"
            self.setViewControllers([mvc], animated: false)
        }
    }
    
    private func removeObservers(){
        let center = NSNotificationCenter.defaultCenter()
        
        if mainSelectedObserver !=  nil {
            center.removeObserver(mainSelectedObserver!)
        }
        if redSelectedObserver != nil {
            center.removeObserver(redSelectedObserver!)
        }
        if greenSelectedObserver != nil {
            center.removeObserver(greenSelectedObserver!)
        }
    }
    
}

