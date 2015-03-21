// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
Subscripts

????What is the subscript usage????

????How to implement the Swift Dictionary type????
*/
class SomeSubscript {
    //    read-write
    subscript(index: Int) -> Int {
        get {
            return 1
        }
        set(newValue) {
            
        }
    }
    //    read-only
    subscript(index: Double) -> Double {
        return 1.0
    }
}

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let timesTable = TimesTable(multiplier: 3)
println("six times three is \(timesTable[6])")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range.")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range.")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 2.4
matrix[1, 1] = 1.2
// error: Index out of range.
//matrix[2, 2] = 1.2
