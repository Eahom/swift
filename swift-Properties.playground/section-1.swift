// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
// error: rangeOfThreeItems.length is a constant value
//rangeOfThreeItems.length = 9
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// error: rangeOfFourItems is a constant value
//rangeOfFourItems.firstValue = 6
let alsoRangeOfThreeItems = rangeOfThreeItems
// error
//alsoRangeOfThreeItems.firstValue = 3
var alsoRangeOfFourItems = rangeOfFourItems
alsoRangeOfFourItems.firstValue = 4

// Lazy Stored Properties

class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
println(manager.importer.fileName)

// Computed Properties

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        //      Shorthand Setter Declaration
        //      a default newValue is used
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
        //        set(newCenter) {
        //            origin.x = newCenter.x - (size.width / 2)
        //            origin.y = newCenter.y - (size.height / 2)
        //        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 1.0, y: 1.0)

// Read-only Computed Properties

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        println("bb")
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
println("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

// Properties Observers

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            println("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                println("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
var stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

// Type Property Syntax

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 0
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty: Int {
        return 1
    }
}
class SomeClass {
    class var computedTypeProperty: Int {
        return 10
    }
    
    class func someTypeMethod() {
        
    }
}
// Querying and Setting Type Properties
println(SomeClass.computedTypeProperty)
println(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
println(SomeStructure.storedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
println(leftChannel.currentLevel)
println(AudioChannel.maxInputLevelForAllChannels)
rightChannel.currentLevel = 11
println(rightChannel.currentLevel)
println(AudioChannel.maxInputLevelForAllChannels)
println(AudioChannel.thresholdLevel)
