//
//  ViewController.swift
//  ServerRemoteControl
//
//  Created by Victor Yurkin on 3/18/16.
//  Copyright © 2016 WCMC. All rights reserved.
//

import UIKit
import Foundation
import NMSSH

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func restartServer(sender: AnyObject) {
        let session = NMSSHSession.connectToHost("66.175.212.71", port: 22, withUsername: "root")
        
        if(session.connected) {
            session.authenticateByPassword("86v89y12g")
            if(session.authorized) {
                print("Success")
            }
        }
        let filePath = NSBundle.mainBundle().pathForResource("Test", ofType: "txt")
        session.channel.uploadFile(filePath, to: "/var/www/html/test.txt")

    }
}

