//: [Previous](@previous)

import Foundation


// https://www.objc.io/quiz/archive/


// 1：分配给可选项
var b: Int? = nil
b? = 10
b // nil

// #2：双重嵌套选项
let s2: String?? = .some(nil)
(s2 ?? "inner") ?? "outer"
s2 //nil


// #3：协议调度
protocol Drawing {
    func render()
}

extension Drawing {
    func circle() { print("protocol") }
    func render() { circle() }
}

class SVG: Drawing {
    func circle() { print("class") }
}

SVG().render() // protocol

// #4：具有自我要求的协议

struct USD: Equatable {
    var cents: Int
    static func ==(l: USD, r: USD) -> Bool {
        return l.cents == r.cents
    }
}

let x = USD(cents: 100)

// Does this compile?

// 39：惰性变量
class X {
    lazy var a: Int? = {
        print("A")
        return nil
    }()
    func b() -> Int? {
        print("B")
        return a ?? 3
    }
    let c: () -> Int = {
        print("C")
        return 5
    }
}
let x2 = X()
x2.b() ?? x2.c()

// BA

// 40：闭包和变量捕获
var language = "Objc"
let code = { [language] in
    print(language)
}
code()
language = "Swift"
let newCode = code
newCode()
// What's the output?

//: [Next](@next)
