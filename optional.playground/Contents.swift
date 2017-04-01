//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## 哨兵值 sentinal value

//: #### Optional 实现细节
enum Optional<T> {
    case some(T)
    case none
}

extension Array where Element: Equatable {
    
    func find(_ element: Element) -> Optional<Index> {
        
        var index = startIndex
        
        while index != endIndex {
            if self[index] == element {
                return .some(index)
            }
            
            formIndex(after: &index)
            
        }
        
        return .none
    }
}

var numbers = [1, 2, 3]
let index = numbers.find(4)
print(type(of: index))
print(type(of: numbers.find(3)))

switch index {
case .some(let index):
    numbers.remove(at: index)
case .none:
    print("No exsit")
}

//: #### Swift 对 optional 类型进行的简化处理

extension Array where Element: Equatable {
    
    func finddd(_ element: Element) -> Index? {
        
        var index = startIndex
        
        while index != endIndex {
            if self[index] == element {
                return index
            }
            
            formIndex(after: &index)
            
        }
        
        return nil
    }
}
let i = numbers.finddd(1)
type(of: i)
switch i {
case let index?:
    numbers.remove(at: index)
case nil:
    print("Not exsit")
}

numbers


//: ## optional use

let num: Int? = 1

num! // force unwrapping

// optional binding

//: #### if let
if let num = num, num % 2 != 0 {
    print(num)
}

//: 需要一连串有可能失败的行为都成功时才执行的动作, 后一步与前一步相关
let imageUrl = "http://upload-images.jianshu.io/upload_images/565029-7d79967cc91e1936.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
if let url = URL(string: imageUrl), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
    
    let view = UIImageView(image: image)
}


//: #### while let

let arr = [1, 2, 3, 4, 5, 6, 7]
var iterator = arr.makeIterator()
while let item = iterator.next() {
    print(item)
}

/*:
 **在Swift里，for...in循环是通过while模拟出来的，这也就意味着，for循环中的循环变量在每次迭代的时候，都是一个全新的对象，而不是对上一个循环变量的修改**
 原因: 弥补由于 Closure 捕获变量带来的一个不算 bug,却也有违直觉的问题
 */

for e in arr {
    print(e)
}

//: ## 使用 guard 简化 optional unwrapping

func arrayProcess(array: [Int]) {
    
    guard let first = array.first else {
        return
    }
    
    print(first)
}


/*:
 返回 Never 表示这类方法直到程序执行结束都不会返回 -- uninhabited type
 使用情况:
 * 崩溃前
 * 类似 dispatchMain 这样在程序生命周期中一直需要执行的方法
 */
func toDO(item: String?) -> Never {
    
    guard let item = item else {
        fatalError("Nothing to do")
    }
    
    fatalError("Implement \(item) later")
}

// 一个伪装的 optional

func arrayP(arr: [Int]) -> String? {
    
    let firstNum: Int // 延迟初始化
    
    if let first = arr.first {
        firstNum = first
    }
    else {
        return nil
    }
    
    return String(firstNum)
}


//: ## Chaining and Nil coalescing

//: #### optional chaining

var swift: String? = "Swift"
let SWIFT = swift?.uppercased().lowercased()
type(of: SWIFT)

extension String {
    func toUppercase() -> String? {
        guard self.characters.count != 0 else {
            return nil
        }
        
        return self.uppercased()
    }
    
    func toLowercase() -> String? {
        
        guard self.characters.count != 0 else {
            return nil
        }
        
        return self.lowercased()
    }
}

let sss = swift?.toUppercase()?.toLowercase()

let nums = ["fibo6": [0, 1, 2, 3, 4, 5]]
//nums["fibo6"]?.[0]

//: #### Nil coalescing  =>  ??

var userInput: String? = nil
let username = userInput != nil ? userInput : "roni"
let nilName = userInput ?? "roni"

var b: String? = nil
var c: String? = "dev"

// 串联
let coalescingName = userInput ?? b ?? c
type(of: coalescingName)

print("为什么需要双层嵌套的 Optional?")
//: ## 为什么需要双层嵌套的 Optional?

let stringOnes: [String] = ["1", "one"]
let intOnes = stringOnes.map{ Int($0) }
type(of: intOnes)
intOnes.forEach{ print($0 ?? "") }

var iteratorInt = intOnes.makeIterator()
type(of: iteratorInt.next())
while let i = iteratorInt.next() {
    print(i ?? "")
}

// 类型匹配
for case let o? in intOnes {
    print(o)
}

//: ## Optional map 和 flatMap 的应用和实现

let op: String? = "Swift"
var OP: String? = nil

if let op = op {
    OP = op.uppercased()
}

//: #### Optional map

// 把 optional 看出 包含值和 nil 的集合
// 对于optional类型来说，如果它的值非nil，map就会把unwrapping的结果传递给它的closure参数，否则，就直接返回nil。 --- map 会对 optional 变量的值自动执行后续的行为
let smap = op.map{ $0.uppercased() }
type(of: smap)
//
//: 对于optional类型来说，如果它的值非nil，map就会把unwrapping的结果传递给它的closure参数，否则，就直接返回nil。

//extension Optional {
//    
//    func myMap<T>(_ transform: (Wrapped) -> T) -> T? {
//        
//        if let value = self {
//            return transform(value)
//        }
//        
//        return nil
//    }
//    
//    // Wrapped 是 Optional 类型的泛型参数, 表示 optional 实际包装的值的类型
//}
//
//let mysmap = op.myMap { $0.uppercased() }

// 理解了这个方式之后，当你再要返回一个optional的时候，除了使用if...else...对非空情况单独处理之外，直接使用map通常会是个更好的方法。

let mans = [1, 2, 3, 4]
let sum = mans.reduce(0, +)
// 重载 Array.reduce
extension Array {
    
    func maReduce(_ nextResult: (Element, Element) -> Element) -> Element? {
        
        guard let first = first else {
            return nil
        }
        
        return dropLast().reduce(first, nextResult)
    }
    
    // 利用 map 自动处理 optional 特性 优化
    func myReduce(_ nextResult: (Element, Element) -> Element) -> Element? {
        
        return first.map{
            dropLast().reduce($0, nextResult)
        }
    }
}

let sum00 = mans.myReduce(+)

//: #### Optional flatMap

let stringOne: String? = "1"
let ooo = stringOne.map{ Int($0) }
type(of: ooo)

// 相比于map来说，flatMap会对它的closure参数的返回值进行处理，当返回非nil时，就直接把这个返回值返回；否则，就返回nil
let nnn = stringOne.flatMap{ Int($0) }
type(of: nnn)

// flatMap 的实现

//extension Optional {
//    
//    // 基于 if...let 实现的
//    func myFlatMap<T>(_ transform: (Wrapped) -> T?) -> T? {
//        
//        if let value = self, let mapped = transform(value) {
//            return mapped
//        }
//        
//        return nil
//    }
//}

//: ## 如何遍历一个不包含 Optional 的集合
let ints = ["1", "2", "3", "4", "five"]
let intso = ints.map{ Int($0) }


// 利用 flatMap 过滤 nil
let f = ints.flatMap{ Int($0) }
f
let all = ints.flatMap{ Int($0) }.reduce(0, +)
all

// flatMap 的 实现
extension Sequence {
    
    func myFlatMapp<T>(_ transform: (Iterator.Element) -> T?) -> [T] {
        
        return self.map(transform).filter{ $0 != nil }.map { $0! } // safely force unwrapping
    }
}

let m = ints.myFlatMapp{ Int($0) }.reduce(0, +)

//: ## 什么时候需要force unwrapping

// 尽可能不要强制解包
// 强制解包在绝对安全的情况下 -- 例如下面以及上面的 myFlatMapp
let episodes = [
    "The fail of sentinal values": 100,
    "Common optional operation": 150,
    "Nested optionals": 180,
    "Map and flatMap": 220,
]

// 安全
episodes.keys
    .filter { episodes[$0]! > 100 }
    .sorted()

// 更好的方式
episodes.filter { (_, duration) in duration > 100 }
    .map { (title, _) in title }
    .sorted()

//: ## 两个调试 optional 的小技巧

/*
// 1. 听过提示让自己死个明白
infix operator !! // infix 定义中序操作符

func !!<T>(optional: T?, errorMsg: @autoclosure () -> String) -> T{
 
    if let value = optional {
        return value
    }
    
    fatalError(errorMsg)
}

var record = ["name": "11"]
// record["type"] !! "Do not have a key named type"

// 2. 进一步改进 force unwrapping 的安全性
// 把调试日志只留在debug mode，并在release mode，为force unwrapping到nil的情况提供一个默认值。就像之前我们提到过的??类似

infix operator !?

// ExpressibleByStringLiteral 将类型约束为 string
func !?<T:protocol<ExpressibleByStringLiteral, ExpressibleByDictionaryLiteral, ExpressibleByBooleanLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByArrayLiteral, ExpressibleByNilLiteral, ExpressibleByUnicodeScalarLiteral, ExpressibleByExtendedGraphemeClusterLiteral>>(optional: T?, nilDefault: @autoclosure () -> (errorMsg: String, value: T)) -> T {
    assert(optional != nil, nilDefault().errorMsg) // 仅在 debug mode 生效
    
    return optional ?? nilDefault().value
}

// 由于Swift并没有提供类似ExpressibleByVoidLiteral这样的protocol，为了方便调试Optional<Void>，我们只能再手动重载一个非泛型版本的!?
func !?(optional: Void?, errorMsg: @autoclosure () -> String) {
    assert(optional != nil, errorMsg())
}

record["type"] !? ("Do not have a key named type", "Free")
record["type"]?
    .write(" account")
    !? "Do not have a key named type"
 */

//: ## 到底该在什么地方使用implicit optional -- 隐式解包 implicitly unwrapped optional

// 出现场景
// 1. 用来传承Objective-C中对象指针的语义
// 2. 用来定义那些初始为nil，但一定会经过既定流程之后，就再也不会为nil的变量

//: #### 用来传承Objective-C中对象指针的语义



//: #### 用来定义那些初始为nil，但一定会经过既定流程之后，就再也不会为nil的变量



