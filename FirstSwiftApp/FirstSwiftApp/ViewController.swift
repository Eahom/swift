//
//  ViewController.swift
//  FirstSwiftApp
//
//  Created by Eahom on 14/12/30.
//  Copyright (c) 2014年 app. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView:UIImageView = UIImageView()
    var backgroundDict:Dictionary<String, String> = Dictionary()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = 320
        let height = 568
        
        backgroundDict = ["Background1":"background1", "Background2":"background2"]
        
        var buttonTitles = ["Background 1", "Background 2"]
        
        var view:UIView = UIView(frame: CGRectMake(0, 0, CGFloat(width), CGFloat(height)))
        self.view.addSubview(view)
        var backgroundImage:UIImage = UIImage(named: backgroundDict["Background1"]!)!
        imageView = UIImageView(frame: view.frame)
        imageView.image = backgroundImage
        view.addSubview(imageView)
        
        for i in 0 ... buttonTitles.count-1 {
            
            var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
            
            button.frame = CGRectMake(0, 0, 200, 20)
            button.center = CGPointMake(view.center.x, CGFloat(100 + i * 50))
            button.setTitle(buttonTitles[i], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.tag = i + 1
            button.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            view.addSubview(button)
        }
    }
    
    func buttonClicked(sender:UIButton) {
        
        var button:UIButton = sender
        var imageSelector:String = "Background\(button.tag)"
        
        UIView.animateWithDuration(0.4, animations: {self.imageView.alpha = 0}, completion: {_ in
            self.imageView.image = UIImage(named: self.backgroundDict[imageSelector]!)
            UIView.animateWithDuration(0.4, animations: {self.imageView.alpha = 1})
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

