// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        
        println("\(name) is being initialized")
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
class Apartment {
    let number: Int
    var tenant: Person?
    
    init (number: Int) { self.number = number }
    deinit { println("Apartment #\(number) is being deinitialized") }
}
var ref1: Person?
var ref2: Person?
var ref3: Person?
ref1 = Person(name: "John Appleseed")
ref2 = ref1
ref3 = ref1
ref1 = nil
ref2 = nil
ref3 = nil
var john: Person?
var number73: Apartment?
john = Person(name: "John Appleseed")
number73 = Apartment(number: 73)
//john!.apartment = number73
number73!.tenant = john
john = nil
number73 = nil

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { println("\(name) is being deinitialized") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    
    init (number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

var joe: Customer?
joe = Customer(name: "Joe Applessed")
joe!.card = CreditCard(number: 1234_5678_9012_3456, customer: joe!)
joe = nil


class Country {
    let name: String
    let capitalCity: City!
    init (name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
    
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
println("\(country.name)'s capital city is called \(country.capitalCity.name)")

class HTMLElement {
    let name: String
    let text: String?
    
     lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        println("\(name) is being deinitialized")
    }
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
println(paragraph!.asHTML())
paragraph = nil

/*
lazy var someClosure: (Int, String) -> String = {
    [unowned self] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
lazy var someClosure: () -> String = {
    [unowned self] in
    // closure body goes here
}
*/

