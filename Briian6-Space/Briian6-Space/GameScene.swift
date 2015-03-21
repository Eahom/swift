//
//  GameScene.swift
//  Briian6-Space
//
//  Created by Eahom on 15/1/27.
//  Copyright (c) 2015年 app. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:SKSpriteNode = SKSpriteNode()
    var lastYieldTimeInterval:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimeInterval:NSTimeInterval = NSTimeInterval()
    var aliensDestroyed:Int = 0
    
    let alienCategory:UInt32 = 0x1 << 1
    let photoTorpedoCategory:UInt32 = 0x1 << 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.blackColor()
        player = SKSpriteNode(imageNamed: "shuttle")
        
        player.position = CGPointMake(self.frame.size.width/2, player.size.height/2 + 20)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAlien() {
        var alien:SKSpriteNode = SKSpriteNode(imageNamed: "alien")
        alien.physicsBody = SKPhysicsBody(rectangleOfSize: alien.size)
        alien.physicsBody?.dynamic = true
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photoTorpedoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        let minX = alien.size.width / 2
        let maxX = self.frame.size.width - alien.size.width / 2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        
        alien.position = CGPointMake(position, self.frame.size.height + alien.size.height)
        
        self.addChild(alien)
        
        let minDuration = 2
        let maxDuration = 4
        let rangeDuration = maxDuration - minDuration
        let duration = Int(arc4random()) % Int(rangeDuration) + Int(minDuration)
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -alien.size.height), duration: NSTimeInterval(duration)))
        actionArray.addObject(SKAction.runBlock({
            var transition: SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            var gameOverScene: SKScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: transition)
        }))
        actionArray.addObject(SKAction.removeFromParent())
        
        alien.runAction(SKAction.sequence(actionArray))
        
    }
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval) {
        
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 1 {
            lastYieldTimeInterval = 0
            addAlien()
        }
    }

    override func update(currentTime: CFTimeInterval) {

        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1 / 60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
    }

    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.runAction(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        var touch: UITouch = touches.anyObject() as UITouch
        var location: CGPoint = touch.locationInNode(self)
        
        var torpedo: SKSpriteNode = SKSpriteNode(imageNamed: "torpedo")
        torpedo.position = player.position
        
        torpedo.physicsBody = SKPhysicsBody(circleOfRadius: torpedo.size.width / 2)
        torpedo.physicsBody?.dynamic = true
        torpedo.physicsBody?.categoryBitMask = photoTorpedoCategory
        torpedo.physicsBody?.contactTestBitMask = alienCategory
        torpedo.physicsBody?.collisionBitMask = 0
        torpedo.physicsBody?.usesPreciseCollisionDetection = true
        
        var offset: CGPoint = vecSub(location, b: torpedo.position)
        
        if offset.y < 0 {
            return
        }
        
        self.addChild(torpedo)
        
        var direction: CGPoint = vecNormalize(offset)
        
        var shotLength: CGPoint = vecMult(direction, b: 1000)
        
        var finalDestinaation: CGPoint = vecAdd(shotLength, b: torpedo.position)
        
        let velocity = 568 / 1
        let moveDuration: Float = Float(self.size.width) / Float(velocity)
        
        var actionArray:NSMutableArray = NSMutableArray()
        actionArray.addObject(SKAction.moveTo(finalDestinaation, duration: NSTimeInterval(moveDuration)))
        actionArray.addObject(SKAction.removeFromParent())
        
        torpedo.runAction(SKAction.sequence(actionArray))
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & photoTorpedoCategory) != 0
            && (secondBody.categoryBitMask & alienCategory) != 0 {
                torpedoDidCollideWithAlien(firstBody.node as SKSpriteNode, alien: secondBody.node as SKSpriteNode)
        }
    }
    
    func torpedoDidCollideWithAlien(torpedo: SKSpriteNode, alien: SKSpriteNode) {
        println("hit:\(aliensDestroyed)")
        
        torpedo.removeFromParent()
        alien.removeFromParent()
        
        ++aliensDestroyed
        
        if aliensDestroyed > 5 {
            var transition: SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            var gameOverScene: SKScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: transition)
        }
        
    }
    
    func vecAdd(a: CGPoint, b: CGPoint)->CGPoint {
        return CGPointMake(a.x + b.x, a.y + b.y)
    }
    
    func vecSub(a: CGPoint, b: CGPoint)->CGPoint {
        return CGPointMake(a.x - b.x, a.y - b.y)
    }
    
    func vecMult(a: CGPoint, b:CGFloat)->CGPoint {
        return CGPointMake(a.x * b, a.y * b)
    }
    
    func vecLength(a: CGPoint)->CGFloat {
        return CGFloat(sqrtf(CFloat(a.x) * CFloat(a.x) + CFloat(a.y) * CFloat(a.y)))
    }
    
    func vecNormalize(a:CGPoint)->CGPoint {
        var length: CGFloat = vecLength(a)
        return CGPointMake(a.x / length, a.y / length)
    }
}

