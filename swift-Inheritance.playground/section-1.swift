// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
*  Inheritance
*/

// Subclassing
class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}
let vehicle = Vehicle()
println("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.currentSpeed = 15.0
println("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
println("Tandem: \(tandem.description)")

// Overriding

// Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        println("choo chon")
    }
}
let train = Train()
train.makeNoise()

// Overriding Properties
// Overriding Property Getters and Setters
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 35.0
car.gear = 4
println("Car: \(car.description)")

// Overriding Property Observers

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automaticCar = AutomaticCar()
automaticCar.currentSpeed = 45.0
println("AutomaticCar: \(automaticCar.description)")
