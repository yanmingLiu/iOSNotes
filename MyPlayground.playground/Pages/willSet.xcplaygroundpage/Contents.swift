//: [Previous](@previous)

import Foundation

var sortArr = [1, 3, 4, 5, 7, 8, 10, 39, 23]
if let index = sortArr.firstIndex(where: {$0 == 5}) {
    print(index)
    
    sortArr.remove(at: index)
    print(sortArr)
}

let a2 = sortArr.map { i in
    return i + 1
}
print(a2)


class Model {
    var x = 0 {
        willSet {
            print("newValue newValue: \(newValue)") // 1
            print("newValue x: \(x)") // 0
            if newValue == x {
                print("newValue 旧值和自己相等")
            } else {
                print("newValue 旧值和自己不相等")
            }
        }
        
        didSet {
            print("didSet oldValue: \(oldValue)") // 0
            print("didSet x: \(x)") // 1
            if oldValue == x {
                print("didSet 旧值和自己相等")
            } else {
                print("didSet 旧值和自己不相等")
            }
        }
    }
}

let m = Model()
m.x = 0


//: [Next](@next)
