//: Playground - noun: a place where people can play

import UIKit
import Foundation

//数据类型

var str = "Hello, playground"
print(str)

var myVariable:Double = 40.0
myVariable = 50
let myConst:Int = 100

sizeofValue(myVariable)
sizeofValue(str)
sizeofValue(myConst)

let label = "字符串"
var width = 99
let string = label + "  " + String(width)
let words = "I print nummber: \(width+1) ."

var shoppingList = ["fish", "frut", "water", "age"]
shoppingList[2] = "apple"
print(shoppingList)

var dictionary = [1:"one",
                  "2":"two",
                  "3":"three"]
dictionary["2"]
dictionary[1]
dictionary["1"] = "wo"
print(dictionary)
shoppingList = []
dictionary = [:]
var arrayTemp = [String]()
var dic = [String:String]()

//====================================

//控制流

let indivi = [75, 43, 103, 87, 12.5]
var count = 0
for score in indivi
{
    if score > 59
    {
        count += 1
    }
}
print("及格\(count)人")

var optionalName:String? = "Jone"
print(optionalName == nil)
var greeting = "Hello!"
if let name = optionalName
{
    greeting = "Hello, \(name)."
}
if optionalName != nil
{
    greeting = "Hello, \(optionalName)."
}

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

let vegetable = "red pepper"
switch vegetable
{
    case "celery":
    print("1")
    case "red":
    print("2")
    case "pepper":
    print("3")
    case let x where x.hasSuffix("pepper"):
    print("4")
    case let x where x.hasPrefix("red"):
    print("5")
default:
    print("default")
}

let interestingNumers = [
    "Prime":[2,3,5,7,11,13],
    "Fibonacci":[1,1,2,3,5,8],
    "Square":[1,4,9,16,25]
]
var largest = 0
for (kind,numbers) in interestingNumers
{
    for number in numbers
    {
        if number == 5
        {
            largest = number
            print(kind+":\(largest)")
        }
        if number > largest
        {
            largest = number
        }
    }
}
print(largest)

var n = 2
while n < 100
{
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

var total = 0
for i in 0..<4  // ..<  ...
{
    total += i
}
print(total)

//=====================================

//函数和闭包

func greet(person:String, day:String) -> String
{
    return "Hello \(person), today is \(day)"
}
greet("Bob", day:"Tuesday")

func sayHi(one person:String, _ day:String) -> String
{
    return "Hello \(person), today is \(day)"
}
sayHi(one :"Bob", "Tuesday")

func calculateStatistics(scores:[Int]) -> (min:Int, max:Int, sum:Int)
{
    var minTemp = scores[0]
    var maxTemp = scores[1]
    var sumTemp = 0
    for score in scores
    {
        if score > maxTemp
        {
            maxTemp = score
        }
        else if score < minTemp
        {
            minTemp = score
        }
        sumTemp += score
    }
    
    return(minTemp, maxTemp, sumTemp)
}
let staticValue = calculateStatistics([3,9,4,7,1,2])
staticValue.sum
staticValue.1

func compareStatistics(scores:[Int]) -> [Int]
{
    var resultArray = scores
    for i in 0..<resultArray.count
    {
        for j in 0..<resultArray.count-i-1
        {
            if resultArray[j] < resultArray[j+1]
            {
                let temp = resultArray[j+1]
                resultArray[j+1] = resultArray[j]
                resultArray[j] = temp
            }
        }
    }
    
    return resultArray
}
compareStatistics([3,9,4,7,1,2])

var array = [Int](count:20, repeatedValue:0)
for index in 0..<20
{
    array[index] = Int(arc4random_uniform(20))+1
}
print("排序前：\(array)")
for item in array
{
    var ii = item
    print(ii)
}
for i in 0..<array.count
{
    for j in 0..<array.count-i-1
    {
        if array[j] > array[j+1]
        {
            var temp = array[j+1]
            array[j+1] = array[j]
            array[j] = temp
        }
    }
}
print("排序后：\(array)")
for item in array
{
    var ii = item
    print(ii)
}

func aveOf(numbers:Int...) -> Float
{
    var sum:Float = 0.0
    for number in numbers
    {
        sum = sum + Float(number)
    }
    let count:Float = Float(numbers.count)
    let ave:Float = sum/count
    return ave
}
aveOf(5,1,3,7,9,10)

func returnFifteen() -> Float
{
    var y:Float = 10
    
    func add(number:Float)
    {
        y += number
    }
    add(1.5)
    return y
}
returnFifteen()

func makeIncre() -> ((Int) -> Int)
{
    func addOne(number: Int) -> Int
    {
        return 1+number
    }
    return addOne
}
var increment = makeIncre()
increment(8)

func hasAnyMatches(list:[Int], condition:(Int)->Bool) -> Bool
{
    for item in list
    {
        if condition(item)
        {
            return true
        }
    }
    return false
}
func lessThanTen(number:Int) -> Bool
{
    return number < 10
}
var numbers = [20,19,7,12]
hasAnyMatches(numbers, condition: lessThanTen)

var newArray = numbers.map { (number:Int) -> Int in
    if number%2 > 0 {
        return 0
    } else {
        return number
    }
}

let mappedNumbers = numbers.map({number in 3 * number})
print(mappedNumbers)
let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)

//========================================================

//对象和类

class Shape: NSObject
{
    var numberOfSides = 0
    let name = "mingzi"
    
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
}
var shape = Shape()
shape.numberOfSides = 10
shape.simpleDescription()

class NamedShape
{
    var numberOfSides: Int = 0
    var name: String
    
    init (name: String)
    {
        self.name = name
    }
    
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides, named \(self.name)"
    }
}
var shape1 = NamedShape.init(name: "wode")
shape1.simpleDescription()

class Square: NamedShape
{
    var sideLength: Double
    var perimeter: Double {
        get {
            return 3.0// * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    
    init(sideLength: Double, name: String)
    {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double
    {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String
    {
        return "A square sides length: \(sideLength)"
    }
}
let testSquare = Square(sideLength: 5.2, name: "mytest")
testSquare.area()
testSquare.simpleDescription()
testSquare.perimeter
testSquare.perimeter = 9.9
print(testSquare.sideLength)
testSquare.perimeter

//=========================================================

//枚举和结构体

enum Rank: Int
{
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String
    {
        switch self
        {
        case .ace:
            return "ace"
        case .two:
            return "two"
        default:
            return String(self.rawValue)
        }
    }
}
let enumTemp = Rank.two
var num = enumTemp.rawValue

struct Card
{
    var rank: Rank
    func simpleDescription() -> String
    {
        return "The \(rank.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three)
let threeOfDesc = threeOfSpades.simpleDescription()

//=========================================================

//协议和扩展

protocol ExampleProtocol
{
    var simpleDescription: String { get }

    mutating func adjust()
}
class simpleClass: ExampleProtocol
{
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69331
    func adjust()
    {
        simpleDescription += " now 100% adjusted."
    }
}
var a = simpleClass()
a.adjust()
let aDesc = a.simpleDescription
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)

extension Int: ExampleProtocol
{
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust()
    {
        self += 42
    }
}
print(7.simpleDescription)

//====================================================

//错误处理

enum PrinterError: ErrorType
{
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String
{
    if printerName == "Never has toner"
    {
        throw PrinterError.noToner
    }
    return "Job send"
}
do {
    let printerResponse = try send( 1040, toPrinter: "Never has toner")
    print(printerResponse)
} catch {
    print(error)
}

//==================================================

//泛型

func repeatItem<Item>(repeating item: Item, numberOfTimes: Int) -> [Item]
{
    var result = [Item]()
    for _ in 0..<numberOfTimes
    {
        result.append(item)
    }
    return result
}
repeatItem(repeating: "knock", numberOfTimes: 4)











