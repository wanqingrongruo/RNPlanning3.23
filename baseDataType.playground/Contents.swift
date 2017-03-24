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

// 0xD800和0xDC00，就叫做surrogate pair
// unicode scalar就是除了surrogate pair之外的code unit
/*
 // 编码单位 code unit 可变是指:
 // UTF-8 中的编码单位是 8位二进制数, 表示一个字符可以通过几个编码单位进行组合
 // UTF-16 中的编码单位是 16位二进制数, 表示一个字符可以通过几个编码单位进行组合
 // UTF-32 中的编码单位是 32位二进制数
 */
