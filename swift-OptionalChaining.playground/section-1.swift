// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    var residence: Residence?
}
class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        println("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}
let john = Person()
// force unwraping
//let roomCount = john.residence!.numberOfRooms
// optional chain
if let roomCount = john.residence?.numberOfRooms {
    println("John's residence has \(roomCount) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}
//john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    println("John's residence has \(roomCount) room(s).")
} else {
    println("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingName = "The Larches"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
if john.residence?.printNumberOfRooms() != nil {
    println("It was possible to print the number of rooms.")
} else {
    println("It was not possible to print the numner of rooms.")
}
if (john.residence?.address = someAddress) != nil {
    println("It was possible to set the address.")
} else {
    println("It was not possible to set the address.")
}
if let firstRoomName = john.residence?[0].name {
    println("The first room name is \(firstRoomName).")
} else {
    println("Unable to retrieve the first room name.")
}

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse
if let firstRoomName = john.residence?[0].name {
    println("The first room name is \(firstRoomName).")
} else {
    println("Unable to retrieve the first room name.")
}

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Dave"]?
testScores["Bev"]?[0]++
testScores["Bev"]?
testScores["Brian"]?[0] = 72
testScores["Brian"]?

// unwrap its actual value with an exclamation mark before accessing the residence's address property
john.residence!.address = someAddress
if let johnsStreet = john.residence?.address?.street {
    println("John's street name is \(johnsStreet)")
} else {
    println("Ubable to retrieve the address")
}

if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    println("John's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        println("John's building identifier begins with \"The\"")
    } else {
        println("John's building identifier does ot begin with \"The\"")
    }
}


