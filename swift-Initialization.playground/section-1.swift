// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Fahrenheit {
    //  var temperature = 32.0 // default property values
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
println("The defult temperature is \(f.temperature) Fahrenheit")

struct Celsius {
    var temperatureInCelsius: Double = 0.0
    // if it is not assign a default value, the init() initializer with empty body will report a complie-time error
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    // do not use external name for initializer parameter
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
    
    init() {
        // if not define this initializer with empty body, even if declare the property with default value, would not use Celsius() to initial the instance
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
let defaultCelsius = Celsius()
let bodyTemperature = Celsius(37.0)
struct Color {
    var red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red    = red
        self.green  = green
        self.blue   = blue
    }
    
    init(white: Double) {
        red     = white
        green   = white
        blue    = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// error: must use external name of initializer parameters, if do not want to use the external name,
// use the under score before the local name
//let veryGreen = Color(0.0, 1.0, 0.0)

class SurveyQuestion {
    var text: String
    var response: String?
    let constantText: String
    
    init(text: String, constantText: String) {
        self.text = text
        self.constantText = constantText
    }
    
    func ask() {
        println(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?", constantText: "Are you hungry?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I am hungry and I like cheese. "

//class ShoppingListItem {
//    var name: String?
//    var quantity = 1
//    var purchased = false
//}
//let item = ShoppingListItem()

struct SomeSize {
    var width, height: Int
}
let someSize = SomeSize(width: 2, height: 2)

struct InitPoint {
    var x = 0.0, y = 0.0
}
struct InitSize {
    var width = 0.0, height = 0.0
}
struct InitRect {
    var origin = InitPoint()
    var size = InitSize()
    
    init() {}
    init(origin: InitPoint, size: InitSize) {
        self.origin = origin
        self.size = size
    }
    init(center: InitPoint, size: InitSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: InitPoint(x: originX, y: originY), size: size)
    }
}
let basicRect = InitRect()
let originRect = InitRect(origin: InitPoint(x: 1.0, y: 1.0), size: InitSize(width: 3.0, height: 3.0))
let centerRect = InitRect(center: InitPoint(x: 5.0, y: 5.0), size: InitSize(width: 3.0, height: 3.0))

// Initializer Inheritance and Overriding

class InitVehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)."
    }
}
class InitBicycle: InitVehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let initVehicle = InitVehicle()
println(initVehicle.description)
let initBicycle = InitBicycle()
println(initBicycle.description)

// Automatic Initializer Inheritance
class Food {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysterItem = RecipeIngredient() // inherit form Food
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"

        return output
    }
}
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    println(item.description)
}
println(breakfastList[0].description)
println(breakfastList[1].description)
println(breakfastList[2].description)

// Failable Initializers

struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    println("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    println("The anonymous creature could not be initialized")
}

// Failable Initializers for Enumerations
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    println("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    println("This is not defined temperature unit, so initialization failed.")
}

// Failabel Initializers for Enumerations with Raw Values

enum TemperatureUnitRawValues: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnitRawValues = TemperatureUnitRawValues(rawValue: "F")
if fahrenheitUnitRawValues != nil {
    println("This is defined temperature unit, so initialization succeeded.")
}
let unknownUnitRawValues = TemperatureUnitRawValues(rawValue: "X")
if unknownUnitRawValues == nil {
    println("This is not a defined temperature unit, so initialization failed")
}

// Failabel Initializers for Classes

class Product {
    let name: String!
    
    init?(name: String) {
        if name.isEmpty { return nil }

        self.name = name
    }
}
if let bowTie = Product(name: "bow tie") {
    println("The product's name is \(bowTie.name)")
}

// Propagation of Initialization Failure

class CartItem: Product {
    let quantity: Int!
    
    init?(name: String, quantity: Int) {
        super.init(name: name)
        
        if quantity < 1 { return nil }
        
        self.quantity = quantity
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    println("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    println("Item \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    println("Unable to initialize zero shirts")
}
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    println("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    println("Unable to initialize one unnamed product")
}

// Overriding a Failabel Initializer

class Document {
    var name: String?
    
    init () {}
    
    init?(name: String) {
        if name.isEmpty { return nil }
        
        self.name = name
    }
}
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        
        self.name = "[Untitled]"
    }
    
    override init?(name: String) {
        super.init()
        
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

// The init! Failable Initializer

// Required Initializers

class SomeClass {
    required init() {
        
    }
}
class SomeSubclass: SomeClass {
    required init() {
        
    }
}

// Setting a Default Property Value with a Closure or Function

struct CheckerBoard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            
            isBlack = !isBlack
        }
        
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = CheckerBoard()
println(board.squareIsBlackAtRow(0, column: 1))
println(board.squareIsBlackAtRow(9, column: 9))












































