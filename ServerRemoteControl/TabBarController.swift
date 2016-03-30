//
//  TabBarController.swift
//  ServerRemoteControl
//
//  Created by Victor Yurkin on 3/29/16.
//  Copyright © 2016 WCMC. All rights reserved.
//

import UIKit
import Foundation

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Change color of top border of Tab Bar
        let border = CALayer()
        let width = CGFloat(1.0)
        let color = UIColor(red: 205/255, green: 86/255, blue: 66/255, alpha: 1)
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: width - self.tabBar.frame.size.height, width: self.tabBar.frame.size.width, height: self.tabBar.frame.size.height)
        border.borderWidth = width
        self.tabBar.layer.addSublayer(border)
        self.tabBar.layer.masksToBounds = true
        self.tabBar.clipsToBounds = true
        
        // Change color of tab bar icons
        self.tabBar.tintColor = color
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: color], forState:.Normal)
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
