//: [Previous](@previous)

import Foundation

struct Person: Hashable {
    var id: Int = 0

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }

    // 实现改法替代hashvalue
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var modelOrderedSet = NSMutableOrderedSet()

for i in 1 ... 5 {
    let p = Person(id: i)
    modelOrderedSet.add(p)
}

print(modelOrderedSet)

print("---------------------")

for i in 3 ... 7 {
    let p = Person(id: i)
    modelOrderedSet.add(p)
}

print(modelOrderedSet)

//: [Next](@next)
