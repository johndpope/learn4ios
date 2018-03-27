//: Playground - noun: a place where people can play

import UIKit
import Learn4iOS

var str = "Hello, playground"

let a = Tensor(data: [1,2,3], shape: [3])
let b = Tensor(data: [1, 2], shape: [2, 1])
let c = a + b

print(c)

let l = parameter(a)
let m = parameter(b)
let k = l + m

print(k.value)
