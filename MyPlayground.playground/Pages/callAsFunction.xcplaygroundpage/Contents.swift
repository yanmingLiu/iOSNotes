//: [Previous](@previous)

import Foundation
import UIKit

struct Adder {
    let value: Int
    func callAsFunction(_ input: Int) -> Int {
      return input + value
    }
}

let add2 = Adder(value: 2)
let result = add2(1)
print(result)



//: [Next](@next)
