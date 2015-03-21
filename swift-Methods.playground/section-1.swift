// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
*  Methods
*/

class Counter {
    var count = 0
    
    func increment() {
        ++self.count
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
    
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    
    func decrementBy(amount: Int, _ numberOfTimes: Int) {
        count -= amount * numberOfTimes
    }
}

let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()
counter.incrementBy(5, numberOfTimes: 3)
counter.decrementBy(3, 3)


struct SPoint {
    var x = 0.0, y = 0.0
    
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    mutating func assignByX(deltaX: Double, y deltaY: Double) {
        self = SPoint(x: x + deltaX, y: y + deltaY)
    }
}
var somePoint = SPoint(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    println("This point is the right of the line where x == 1.0")
}
somePoint.moveByX(2.0, y: 1.5)
somePoint.assignByX(1.5, y: -1.0)

enum TriStateSwitch {
    case Off, Low, High
    
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
if ovenLight == .Low {
    println("Low" )
}
ovenLight.next()
if ovenLight == .High {
    println("High" )
}
ovenLight.next()
if ovenLight == .Off {
    println("Off" )
}


struct LevelTracker {
    static var highestUnlockLevel = 1
    
    static func unlockLevel(level: Int) {
        if level > highestUnlockLevel {
            highestUnlockLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "player")
player.completedLevel(1)
println("highest unlock level is now \(LevelTracker.highestUnlockLevel)")
player = Player(name: "beto")
if player.tracker.advanceToLevel(6) {
    println("player is now on level 6")
} else {
    println("level 6 has not yet been unlocked ")
}
