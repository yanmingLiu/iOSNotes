//: [Previous](@previous)

import Foundation

// 创建
let setA: Set<String> = ["a","b","c"]
let setB: Set = ["a","b","c"]
let setC = Set(["a","b","c"])
var setD = Set(setC)

// 访问集合中的元素
for value in setA {
     print(value)
    // 注意：每次运行代码时，循环中值的顺序可能不同。从表面来看，它们像是随机返回一样。
}

// 属性 方法
print("isEmpty = \(setA.isEmpty)")
print("count = \(setA.count)")
print("contains = \(setA.contains("a"))")

setD.insert("c")
setD.remove("a")

print("== \(setA == setC)")

// 检查一个集合是否是另一个集合的子集：
let intSetA: Set = [1,2,3,4,5,6,7,8,9,0]
let intSetB: Set = [1,2,3]
let intSetC: Set = [1,2,3,4,5,6,7,8,9,0]

let isSubset = intSetB.isSubset(of: intSetA)
print("isSubset = \(isSubset)")

// 检查集合是否是另一个集合的真子集。这种情况就是该集合是另一个集合的子集但不想等。
let isStrictSubsetBA = intSetB.isStrictSubset(of: intSetA)
let isStrictSubsetCA = intSetC.isStrictSubset(of: intSetA)
print("isStrictSubset B A = \(isStrictSubsetBA)")
print("isStrictSubset C A = \(isStrictSubsetCA)")


// 与之相对的概念就是超集
let isSupersetAB = intSetA.isSuperset(of: intSetB)
let isSupersetAC = intSetA.isStrictSuperset(of: intSetC)
print("isSupersetAB = \(isSupersetAB)")
print("isSupersetAC = \(isSupersetAC)")

// 如果两个集合没有相同的元素，那么就说这两个集合不相交
let intSetE: Set = [13,14,15]
let isDisjoint = intSetA.isDisjoint(with: intSetE)
print("isDisjoint = \(isDisjoint)")

// 将两个集合合并成为一个新集合，新的集合中包含两个集合中所有的元素：
let unionSetAB = intSetA.union(intSetB)
print("unionSetAB = \(unionSetAB)")

// 交集就是仅包含两个集合中共同的元素：
let intersectionAB = intSetA.intersection(intSetB)
print("intersectionAB = \(intersectionAB)")

// setA 去掉 SetB中的元素
let subtracting = intSetA.subtracting(intSetB)
print("subtracting = \(subtracting)")

// MARK: - IndexSet

/*
表示一个有正整数组成的集合，我们其实可有用Set 达到同等效果。 但IndexSet更加 高效 ，内部使用了 一组范围列表 进行实现。 eg.
存储1到1000
set可能是[1,2,3,4,......,1000]
IndexSet的内部只是真正存储了1,1000  首位和末位两个数字。 它会存储```连续的范围```。So 会更加高效
*/


//: [Next](@next)
