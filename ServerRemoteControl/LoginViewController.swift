//
//  LoginController.swift
//  ServerRemoteControl
//
//  Created by Victor Yurkin on 3/25/16.
//  Copyright © 2016 WCMC. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.viewContainer.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.viewLogo.center.y -= 150.0
        }, completion: {
            (value: Bool) in
            self.viewContainer.alpha = 0.0
            self.viewContainer.hidden = false
            UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.viewContainer.alpha = 1.0
            }, completion: nil)
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController as! UITabBarController
    }
    
}
