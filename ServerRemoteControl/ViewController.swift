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

    var sftp:NMSFTP!
    var timer: dispatch_source_t!
    
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelResponse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = NMSSHSession.connectToHost("140.251.7.146", port: 22, withUsername: "viy2003")
        if(session.connected) {
            session.authenticateByPassword("86V89y12g")
            if(!session.authorized) {
                print("Failed")
            }
        }
        let sftp = NMSFTP.connectWithSession(session)
        if(!sftp.connected) {
            print("SFTP Failed")
        }else {
            self.sftp = sftp
        }
        
        // Start monitoring status
        self.startTimer()
        
        //Check apache status
        //do {
            //let response = try sftp.session.channel.execute("/bin/bash /var/www/html/server_control_api/status.sh")
            //let response = try self.sftp!.session.channel.execute("php /var/www/html/server_control_api/index.php")
            //self.labelStatus.text = "Current Status: " + response
            //if(response == "down") {
            //    self.labelStatus.textColor = UIColor.redColor()
            //}
        //} catch {
        //    print("An error occurred.")
        //}
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
        
        let filePath = NSBundle.mainBundle().pathForResource("restart", ofType: "txt")
        self.sftp!.writeFileAtPath(filePath, toFileAtPath: "/var/www/html/server_control_api/restart.txt")
        
        self.labelResponse.text = "restart requested..."
        
    }
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            self.updateStatus();
        }
        dispatch_resume(timer)
    }
    
    func stopTimer() {
        dispatch_source_cancel(timer)
        timer = nil
    }
    
    func updateStatus() {
        dispatch_async(dispatch_get_main_queue(), {
            let response = self.sftp.contentsAtPath("/var/www/html/server_control_api/response.txt")
            let responseTxt = NSString(data: response, encoding: NSUTF8StringEncoding) as! String
            self.labelResponse.text = responseTxt
        })
    }
    
}

