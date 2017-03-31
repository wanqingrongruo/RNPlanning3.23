//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// 十进制
let fifteenInDecimal = 15
// 十六进制
let fifteenInHex = 0xF
// 八进制
let fifteenInOctal = 0o17
// 二进制
let fifteenInBinary = 0b1111

let million = 1_000_000

var PI = 314e-2

// "一个在屏幕上显示的字符可能由多个code unit组合而成。"

// 0xD800和0xDC00，就叫做surrogate pair
// unicode scalar就是除了surrogate pair之外的code unit
/*
 // 编码单位 code unit 可变是指:
 // UTF-8 中的编码单位是 8位二进制数, 表示一个字符可以通过几个编码单位进行组合
 // UTF-16 中的编码单位是 16位二进制数, 表示一个字符可以通过几个编码单位进行组合
 // UTF-32 中的编码单位是 32位二进制数
 */


// Unicode grapheme clusters 字素簇

// é , 它的unicode scalar是U00e9
// 英文字母e，它的unicode scalar是U0065，name是LATIN SMALL LETTER E
// 声调字符'，它的unicode scalar是U0301，name是COMBINING ACUTE ACCENT

let cafe = "Caf\u{00e9}"
var cafee = "Caf\u{0065}\u{0301}"


// Canonically equivalent  标准相等

cafe.characters.count
cafee.characters.count


// é的UTF-8编码是C3 A9
cafe.utf8.count
// 声调字符'的UTF-8编码是CC 81
cafee.utf8.count

cafe.utf16.count
cafee.utf16.count

cafe == cafee

// NSString

let nsCafe = NSString(characters: [0x43, 0x61, 0x66, 0xe9], length: 4)
let nsCafee = NSString(characters: [0x43, 0x61, 0x66, 0x65, 0x0301], length: 5)

nsCafe.length
nsCafee.length

nsCafe == nsCafee

// ==对NSString来说，并没有执行canonically equivalent的语义

let result = nsCafe.compare(nsCafee as String)
result == ComparisonResult.orderedSame

// 为什么String不是一个Collection类型？

extension String: Collection {
    
}

// 面对unicode复杂的组合规则，我们很难保证所有的集合算法都是安全并且语义正确的。
cafee.dropFirst(4)
 // cafee.dropLast()   // cash

// 使用不能的 View 去告诉 String 类型如何去理解字符串中的内容. 这些 View 是 String 的不同属性
// 划分方式
// 1. unicodeScalar: 按照字符中每个字符的 Unicode scalar 来形成集合
// 2. utf8: 按照字符串中每个字符的 UTF-8 编码来形成集合
// 3. utf16: 按照字符串中每个字符的 UTF-16 编码来形成集合

// Swift 把 UTF-32 码元叫做「Unicode 标量（unicode scalars）」

print("******** 划分 *********")

cafee.unicodeScalars.forEach { (c) in
    print(c)
}
cafee.utf8.forEach { (c) in
    print(c)
}
cafee.utf16.forEach { (c) in
    print(c)
}

cafee.unicodeScalars.dropLast(1)
cafee.utf16.dropLast(1)
cafee.utf8.dropLast(1)

// String.CharacterView

cafee.characters.count
cafee.characters.startIndex
cafee.characters.endIndex // 最后一个字符的下一个位置
// endIndex == 5 是因为 Index是面向集合的，它不处理Unicode语义，但是characters这个属性却是带有unicode语义的，所以就会这样。。。

cafe.characters.count
cafe.characters.endIndex


cafee.utf8.count
cafee.utf8.endIndex



"hello".characters.count
"hello".characters.startIndex
"hello".endIndex


//public struct String {
//    /// The index type for subscripting a string.
//    public typealias Index = String.CharacterView.Index
//}

// characters属性中的索引，是可以直接用来索引字符串特定位置的。但是由于你无法确定两个字符之间到底相隔了多少字符，因此，你并不能像访问一个Array一样去使用characters：
// cafee.characters[2] //　wrong!!!!

// `String.CharacterView只遵从了BidirectionalCollection protocol，因此，它只能顺序向前，或者向后移动，而不能随机指定位置移动。如果我们要获得特定位置的字符，只能使用index(_:offsetBy:)这个方法。例如：
let index = cafee.index(cafee.startIndex, offsetBy: 3)
cafee[index]

let index0 = cafee.index(cafee.characters.endIndex, offsetBy: -1)
cafee[index0]


// limitedBy - 限制越界
let index01 = cafee.index(cafee.characters.startIndex, offsetBy: 100, limitedBy: cafee.endIndex) // 越界返回 nil


// 基于unicode的字符串常用操作

// 前缀
let pre = cafee.characters.prefix(3)
String(pre)

// 遍历
for (index, value) in cafee.characters.enumerated() {
    print("\(index): \(value)")
}

 // 插入内容
if let index = cafee.characters.index(of: "a") {
    index
    cafee.insert(contentsOf: "9", at: index)
}

// 基于 Range 的查找和替换
var mixStr = "Swift很有趣"
if let s = mixStr.characters.index(of: "很") {
    mixStr.replaceSubrange(s ..< mixStr.endIndex, with: " is interesting!")
}

// 字符串切片
let view = mixStr.characters.suffix(12).dropLast()
String(view)
let strView = mixStr.characters.split(separator: " ")
strView.map(String.init)

var i = 0
let singleCharViews = mixStr.characters.split { _ in
    if i > 0 {
        i = 0
        return true
    }
    else {
        i += 1
        return false
    }
}

singleCharViews.map(String.init)


// 使用 Tuple 打包数据

let success = (200, "OK")
let fileNotFound = (404, "File not found")

let me = (name: "roni", no: 28, email: "zwxwqrr@gmail")

me.name
me.1

// Tuple Decomposition
var (sCode, smsg) = success
sCode
smsg

sCode = 500
success

let (_, error) = fileNotFound
error

// Tuple type -- type annotation(注释,注解)

var redirect: (Int, String) = (302, "temporary redirect")

// Tuple comparison

let tuple01 = (1, 2)
let tuple02 = (1, 2, 3)

// 个数类型相同,逐个元素比较
// tuple01 < tuple02 // compare error

let largeTuple1 = (1, 2, 3, 4, 5, 6, 7)
let largeTuple2 = (1, 2, 3, 4, 5, 6, 7)

// 最多包含6个元素进行比较
// largeTuple1 == largeTuple2 // Error !!!

// 使用 Markdown 编写代码注释


