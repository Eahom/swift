//
//  GameOverScene.swift
//  Briian6-Space
//
//  Created by Eahom on 15/2/5.
//  Copyright (c) 2015年 app. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won: Bool) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        var message: NSString = NSString()
        
        if won {
            message = "You Win!"
        } else {
            message = "Game Over!"
        }
        
        var label: SKLabelNode = SKLabelNode(fontNamed: "DamascusBold")
        label.text = message
        label.fontColor = SKColor.whiteColor()
        label.position = CGPointMake(self.size.width / 2, self.size.height / 2)
    
        self.addChild(label)
        
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3.0),
            SKAction.runBlock({
                var transition: SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                var scene: SKScene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            })]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
