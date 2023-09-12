//: [Previous](@previous)

import Foundation
import UIKit

var registerMap = [String: Int]()
registerMap.updateValue(2, forKey: "key")
print(registerMap)



// MARK: - 知识点1：书中提到了可以用updateValue(_:forKey:) 获取到更新新值之前如果有值的旧值。
/// 得到更新键值对之前的值 updateValue
var dict = ["name":"liaoWorking","age":"17"]
let oldValue = dict.updateValue("18", forKey: "age")
print(oldValue) // Optional("17")
print(dict["age"]) //Optional("18")

// MARK: - enumerated

var dic1 = ["a": 1, "b": 2]
let dic2 = ["a": 1, "b": 2]
let dic3 = ["a": 1, "b": "3"] as [String: Any]
let dic4 = ["a": 1, "b": ["c": 3]] as [String: Any]

for (k, v) in dic1.enumerated() {
    print("enumerated: \(k) - \(v)")
}

dic1.removeValue(forKey: "a")
print(dic1)
print(dic1 == dic2)

// MARK: - merge 注：闭包里面的处理是逻辑是当两个dict 有相同的key return出我们觉得合适的value.

var oldDict = ["name":"liaoWorking","age":"17"]
var newDict = ["name":"Jane","age":"19","gender":"M"]

oldDict.merge(newDict) { (dictValue, newDictValue) -> String in
    print("merge: dictValue = \(dictValue)")    // liaoworking 相同key时候的dictValue
    print("merge: newDictValue = \(newDictValue)")     //Jane 相同key时候的newDictValue
    return newDictValue //返回你觉得应该选择的value 我这里默认都是newDictValue
}
print("merge:\(newDict)") //["name": "Jane", "age": "19", "gender": "M"]



// MARK: - map mapValues

let map1 = ["name":"liaoWorking","age":"17"].map({$0.value})
print("map: \(map1)")

///字典的map方法
let mapDict = ["name":"liaoWorking","age":"17"].mapValues { (value) -> String in
    return "new"+value
}
print("mapValues: \(mapDict)")//["name": "newliaoWorking", "age": "new18"]

//: [Next](@next)
