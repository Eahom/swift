//
//  ViewController.swift
//  Brain3
//
//  Created by Eahom on 15/1/8.
//  Copyright (c) 2015 app. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UITextFieldDelegate{

    @IBOutlet var tableView: UITableView! = UITableView()
    
    var dataSource:NSMutableArray = NSMutableArray()
    var headerView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.frame = CGRectMake(0, 0, 320, 200)
        headerView.backgroundColor = UIColor.blackColor()
        
        tableView.tableHeaderView = headerView
        
        var nameTextField:UITextField = UITextField(frame: CGRectMake(0, 0, 150, 45))
        nameTextField.center = headerView.center
        nameTextField.backgroundColor = UIColor.whiteColor()
        nameTextField.textAlignment = NSTextAlignment.Center
        nameTextField.placeholder = "Enter your name"
        nameTextField.delegate = self
        
        headerView.addSubview(nameTextField)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let kCellIdentifier = "cellIdentifer"
            var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
            
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier)
            }
            
            cell.textLabel?.text = "Hello \(dataSource.objectAtIndex(indexPath.row))"
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var alert:UIAlertController = UIAlertController(title: "Message", message: "Thanks for clicking", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Close AlertView", style: UIAlertActionStyle.Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Change header color", style: UIAlertActionStyle.Default, handler: {alertAction in
            UIView.animateWithDuration(2.5,
                animations: {
                    self.headerView.backgroundColor = (self.headerView.backgroundColor == UIColor.blackColor() ? UIColor.blueColor() : UIColor.blackColor())
                },
                completion: {_ in
                    println("Animation complete")
            })
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        dataSource.addObject(textField.text)
        
        tableView.reloadData()
        
        textField.text = ""
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

