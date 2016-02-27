//
//  RmdContainerViewController.swift
//  RmdRevealViewController
//
//  Created by Nguyen Hoang Nam on 27/2/16.
//  Copyright © 2016 Alan Nguyen. All rights reserved.
//

import UIKit

class RmdContainerViewController: UIViewController {
    
    var leftViewController: UIViewController? {
        willSet{
            if self.leftViewController != nil {
                if self.leftViewController!.view != nil {
                    self.leftViewController!.view!.removeFromSuperview()
                }
                self.leftViewController!.removeFromParentViewController()
            }
        }
        
        didSet{
            self.view!.addSubview(self.leftViewController!.view)
            self.addChildViewController(self.leftViewController!)
        }
    }
    
    var rightViewController: UIViewController? {
        willSet {
            if self.rightViewController != nil {
                if self.rightViewController!.view != nil {
                    self.rightViewController!.view!.removeFromSuperview()
                }
                self.rightViewController!.removeFromParentViewController()
            }
        }
        
        didSet{
            self.view!.addSubview(self.rightViewController!.view)
            self.addChildViewController(self.rightViewController!)
        }
    }
    
    var mainNavigation: RmdNavigationController!
    
    var menuShown: Bool = false
    
    private var openMenu: NSObjectProtocol?
    private var closeMenu: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuViewController: RmdMenuViewController = RmdMenuViewController()
        let mvc: RmdViewController = RmdViewController()
        mainNavigation = RmdNavigationController(rootViewController:mvc)
        self.leftViewController = menuViewController
        self.rightViewController = mainNavigation
        addObservers()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let menu = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action:"touchMenu:")
        mainNavigation.viewControllers.first?.navigationItem.leftBarButtonItems = [menu]
    }
    
    func touchMenu(object:AnyObject) {
        showMenu()
    }
    
    private func addObservers() {
        let center = NSNotificationCenter.defaultCenter()
        openMenu = center.addObserverForName("openMenu", object: nil, queue: nil) { (notification: NSNotification!) in
            self.showMenu()
        }
        closeMenu = center.addObserverForName("closeMenu", object: nil, queue: nil) { (notification: NSNotification!) in
            let menu = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action:"touchMenu:")
            self.mainNavigation.viewControllers.first?.navigationItem.leftBarButtonItems = [menu]
            self.hideMenu()
        }
    }
    
    private func removeObservers(){
        let center = NSNotificationCenter.defaultCenter()
        if closeMenu !=  nil {
            center.removeObserver(closeMenu!)
        }
        if openMenu !=  nil {
            center.removeObserver(openMenu!)
        }
    }
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        showMenu()
        
    }
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        hideMenu()
    }
    
    func showMenu() {
        UIView.animateWithDuration(0.2, animations: {
            self.rightViewController!.view.frame = CGRect(x: self.view.frame.size.width - 64, y: self.view.frame.origin.y,
                width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (Bool) -> Void in
                self.menuShown = true
                self.reloadShadow(self.rightViewController!.view)
        })
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.2, animations: {
            self.rightViewController!.view.frame = CGRect(x: 0, y: self.view.frame.origin.y,
                width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (Bool) -> Void in
                self.menuShown = false
        })
    }
    
    func reloadShadow(view:UIView)
    {
        let frontViewLayer = view.layer
        frontViewLayer.shadowColor = UIColor.blackColor().CGColor
        frontViewLayer.shadowOpacity = 0.7
        frontViewLayer.shadowOffset = CGSize(width: 1,height: 1)
        frontViewLayer.shadowRadius = 3.0
    }
    
}