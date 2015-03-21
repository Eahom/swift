// Playground - noun: a place where people can play

import Cocoa

println("hello, world!")

var str = "Hello, playground"

var myVariable = 42
myVariable = 50

let myConstant = "Hello, World!"

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

let explictFloat: Float = 4;

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//let widthLabelError = label + width

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let expApples: Float = 3;
let expOranges: Float = 2.3;
let expAppleSummary = "I test \(expApples) apples."
let expOrangeSummary = "I test \(expOranges) oranges."
let expFruitSummary = "I test \(expApples + expOranges) pieces of fruit."

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
let emptyArray = [String]()
let emptyDictionary = Dictionary<String, Float>()

shoppingList = []
occupations = [:]

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
teamScore

var optionalString: String? = "Hello"
optionalString == nil
var optionalName:String? = "John Applessed"
var greeting = "Hello"
if  let name = optionalName {
    greeting = "Hello, \(name)"
}

if optionalName == nil {
    greeting += "name is nil"
} else {
    greeting += "Hello, \(optionalName)"
}


let vegetable = "red peper"
switch vegetable {

case "celery":
    let vegetableComment = "Add some raisins and make ants on log."
    
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwichi."

case let x where x.hasSuffix("peper"):
    let vegetableComment = "Is it a spicy \(x)"
    
default:
    let vegetableComment = "Everything tastes good in soup."
}


let interestingNumbers = [

    "Primie": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0
var largestName = "unknow"
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestName = kind
        }
    }
}
largest
largestName


var n = 2
while n < 100 {
    n = n * 2
}
n

var m = 2
do {
    m = m * 2
} while m < 100
m


var firstForLoop = 0
for i in 0..<3 {
    firstForLoop += i
}
firstForLoop



func greet (name: String, day: String) -> String {
    return "Hello \(name), today is \(day)"
}

greet("Bob", "Tuesday")

func greetLanuch(name: String, lanuch: String) -> String {
    return "Hello \(name), \(lanuch)"
}

greetLanuch("Bob", "noodless")

func getGasPrices() -> (Double, Double, Double) {
    return (3.59, 3.69, 3.79)
}
getGasPrices()

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    
    return sum
}

sumOf()
sumOf(42, 597, 12)

var x:Int
x = 1
x

var imOptionalVariable:Int?
imOptionalVariable = 12

let userInput = "qwe"
var age = userInput.toInt()

if age != nil
{
    println("your age is " + String(age!))
    age
    age!
}
else
{
    println("invalid userInput")
}


//optional binding
if let userAge = userInput.toInt()
{
    println("your age is \(userAge)")
    userAge
}
else
{
    println("invalid userInput: \(userInput)")
}

var z:Int!

let a = 5
let b = 2
let c = 0

a + b
a - b
a * b
a / b
a % b

//a / c
//a % c























