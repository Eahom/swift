//
//  ViewController.swift
//  Brain5-Notifications
//
//  Created by Eahom on 15/1/11.
//  Copyright (c) 2015年 app. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "drawAShape:", name: "actionFirstPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAMessage:", name: "actionSecondPressed", object: nil)
        
        if UIApplication.sharedApplication().scheduledLocalNotifications.count == 0 {
            var notification:UILocalNotification = UILocalNotification()
            notification.category = "FIRST_CATEGORY"
            notification.alertBody = "Hi, I am a notification"
            notification.fireDate = NSDate()
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
    }
    
    func drawAShape(notification:NSNotification) {
        var view:UIView = UIView(frame: CGRectMake(30, 30, 50, 50))
        view.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(view)
    }
    
    func showAMessage(notification:NSNotification) {
        var msg:UIAlertController = UIAlertController(title: "Notification Second Action Test", message: "Hello Local Notification", preferredStyle: UIAlertControllerStyle.Alert)
        msg.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(msg, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

