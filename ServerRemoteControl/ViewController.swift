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
        /*
        let session = NMSSHSession.connectToHost("66.175.212.71", port: 22, withUsername: "root")
        
        if(session.connected) {
            session.authenticateByPassword("86v89y12g")
            if(session.authorized) {
                print("Success")
            }
        }
        let filePath = NSBundle.mainBundle().pathForResource("Test", ofType: "txt")
        session.channel.uploadFile(filePath, to: "/var/www/html/test.txt")
        */

        let session = NMSSHSession.connectToHost("140.251.7.146", port: 22, withUsername: "viy2003")
        if(session.connected) {
            session.authenticateByPassword("86V89y12g")
            if(session.authorized) {
                print("Success")
            }
        }
        let sftp = NMSFTP.connectWithSession(session)
        if(sftp.connected) {
            print("SFTP Success")
        }
        
        let filePath = NSBundle.mainBundle().pathForResource("Test", ofType: "txt")
        sftp.writeFileAtPath(filePath, toFileAtPath: "/var/www/html/test/test123.txt")
        
        
        
    }
}

