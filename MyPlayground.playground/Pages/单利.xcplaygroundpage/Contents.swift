//: [Previous](@previous)

import Foundation
import UIKit

func address(_ obj: UnsafeRawPointer) -> String {
    return String(format: "%018p", Int(bitPattern: obj))
}

class JionManager {
    var id = 1
    
//    private static let staticInstance = JionManager()
//    static func shared() -> JionManager {
//        return staticInstance
//    }
    
    static var shared = JionManager()
    
    private init() {}
}

var jd1 = JionManager.shared
var jd2 = JionManager.shared
jd2.id = 2

print(address(&jd1))
print(address(&jd2))
print(jd1.id)
print(jd2.id)



//: [Next](@next)
