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

class DetailsViewController: UIViewController {

    var sftp:NMSFTP!
    var timer: dispatch_source_t!
    var serverIP: String!
    
    @IBOutlet weak var viewStatusBar: UIView!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelResponse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set border radius for status bar
        self.viewStatusBar.layer.cornerRadius = 6
        
        // Start monitoring status
        self.startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.stopTimer()
    }

    @IBAction func restartServer(sender: AnyObject) {
        let filePath = NSBundle.mainBundle().pathForResource("restart", ofType: "txt")
        self.sftp!.writeFileAtPath(filePath, toFileAtPath: "/var/www/html/server_control_api/restart.txt")
        self.labelResponse.text = "restart requested..."
    }
    
    func startTimer() {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC, 1 * NSEC_PER_SEC) // every 60 seconds, with leeway of 1 second
        dispatch_source_set_event_handler(timer) {
            if(self.sftp == nil) {
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
            }
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
            print(responseTxt)
 /*
            do {
                try self.sftp.session.channel.execute("/sbin/service httpd status > /var/www/html/server_control_api/test123.txt")
                let responseTxt = self.sftp.contentsAtPath("/var/www/html/server_control_api/test123.txt")
                let responseTxtStr = NSString(data: responseTxt, encoding: NSUTF8StringEncoding) as! String
                self.labelResponse.text = responseTxtStr
                print(responseTxtStr)
            } catch {
                print("An error occurred.")
            }
*/
        })
    }
    
}

