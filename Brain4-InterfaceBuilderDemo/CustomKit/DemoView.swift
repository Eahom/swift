//
//  DemoView.swift
//  Brain4-InterfaceBuilderDemo
//
//  Created by Eahom on 15/1/9.
//  Copyright (c) 2015年 app. All rights reserved.
//

import UIKit

@IBDesignable
class DemoView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var label:UILabel = UILabel(frame: CGRectMake(20, 25, 40, 20))
        label.text = "Hello"
        label.textColor = UIColor.blueColor()
        
        self.addSubview(label)
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView(effect: blur)
        
        effectView.frame = CGRectMake(0, 30, 50, 50)
        
        self.addSubview(effectView)
    }

}
