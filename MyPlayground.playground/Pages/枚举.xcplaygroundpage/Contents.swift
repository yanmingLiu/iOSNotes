//: [Previous](@previous)

import Foundation

// 递归枚举
enum RE {
    case v(String)
    indirect case node(l:RE, r:RE)
}
let lNode = RE.v("left")
let rNode = RE.v("right")
let pNode = RE.node(l: lNode, r: rNode)
switch pNode {
case .v(let string):
    print(string)
case .node(let l, let r):
    print(l,r)
    switch l {
    case .v(let string):
        print(string)
    case .node(let l, let r):
        print(l, r)
    }
    switch r {
    case .v(let string):
        print(string)
    case .node(let l, let r):
        print(l, r)
    }
}

// 使用 enum 来创建一个枚举。就像类和其他所有命名类型一样，枚举可以包含方法。
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

/*
 swift 按照从 0 开始每次加 1 的方式为原始值进行赋值，不过你可以通过显式赋值进行改变。在上面的例子中，
 Ace 被显式赋值为 1，并且剩下的原始值会按照顺序赋值。你也可以使用字符串或者浮点数作为枚举的原始值。
 使用 rawValue 属性来访问一个枚举成员的原始值。
 使用 init?(rawValue:) 初始化构造器来从原始值创建一个枚举实例。如果存在与原始值相应的枚举成员就返回该枚举成员，否则就返回 nil。
 */

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

// 枚举的关联值是实际值，并不是原始值的另一种表达方法。实际上，如果没有比较有意义的原始值，你就不需要提供原始值。

enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

/*
 如果枚举成员的实例有原始值，那么这些值是在声明的时候就已经决定了，这意味着不同枚举实例的枚举成员总会有一个相同的原始值。
 当然我们也可以为枚举成员设定关联值，关联值是在创建实例时决定的。
 这意味着同一枚举成员不同实例的关联值可以不相同。
 你可以把关联值想象成枚举成员实例的存储属性。
 例如，考虑从服务器获取日出和日落的时间的情况。服务器会返回正常结果或者错误信息。

 */

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure...  \(message)")
}

//: [Next](@next)
