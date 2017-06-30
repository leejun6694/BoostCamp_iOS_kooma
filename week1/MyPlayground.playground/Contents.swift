//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str
//constStr = "Hello, World"

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool
//var arrayOfInts: Array<Int>
var arrayOfInts: [Int]
//var dictionaryOfCapitalsByCountry: Dictionary<String, String>
var dictionaryOfCapitalsByCountry: [String:String]
var winningLotteryNumbers: Set<Int>

let number = 42
let fmStation = 91.1

//let countingUp = ["one", "two"]
var countingUp = ["one", "two"]
let secondElement = countingUp[1]   // String의 instance라 할 수 있다
countingUp.count
countingUp.append("three")

let nameByParkingSpace = [13: "Alice", 27: "Bob"]
//let space13Assignee: String? = nameByParkingSpace[13]
if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 is assigned in the dictionary")
}
let space42Assignee: String? = nameByParkingSpace[42]

// initialize nothing
let emptyString = String()
emptyString.isEmpty
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()

// initialize default value
let defaultNumber = Int()
let defaultBool = Bool()

// many initializer return int value -> String
let meaningOfLife = String(number)
// set initializer
let availableRooms = Set([205, 411, 412])
// Float initializer
let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14   // 부동 소수점 리터럴은 type inference -> Double
let floatFromDouble = Float(easyPi)

var reading1: Float?
var reading2: Float?
var reading3: Float?
reading1 = 9.8
reading2 = 9.2
//reading3 = 9.7
//let avgReading = (reading1 + reading2 + reading3) / 3
//let avgReading = (reading1! + reading2! + reading3!) / 3

if let r1 = reading1, let r2 = reading2, let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = "Instrument reported a reading that was nil"
}

for i in 0 ..< countingUp.count {
    let string = countingUp[i]
}

for string in countingUp {
    
}

for (i, string) in countingUp.enumerated() {
    
}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum PieType: Int {
    case Apple = 0
    case Cherry
    case Pecan
}

let favoritePie = PieType.Apple

let name: String
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"
}

let pieRawValue = PieType.Pecan.rawValue
if let pieType = PieType(rawValue: pieRawValue) {
    
}