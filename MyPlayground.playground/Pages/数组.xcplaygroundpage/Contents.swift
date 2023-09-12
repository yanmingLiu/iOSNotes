//: [Previous](@previous)

import Foundation

struct HomeADModel: Equatable {
    var code: String?
}

extension HomeADModel {
    static func == (lhs: HomeADModel, rhs: HomeADModel) -> Bool {
        return lhs.code == rhs.code
    }
}

class ProductDetail: Equatable {
    static func == (lhs: ProductDetail, rhs: ProductDetail) -> Bool {
        let res = lhs.id > 0 && rhs.id > 0 && lhs.id == rhs.id && lhs.json == rhs.json
        print("Equatable: \(res)")
        return res
    }

    var id: Int = 0
    var json: HomeADModel?

    init(id: Int, json: HomeADModel?) {
        self.id = id
        self.json = json
    }
}

extension Array {
    // 去重
    func deduplication<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        print("result = \(result)")

        for value in self {
            let key = filter(value)
            print("key = \(key), value = \(value)")
            if !result.map({ filter($0) }).contains(key) {
                result.append(value)
            }
        }
        print("result = \(result)")

        return result
    }
}


var arr1 = [ProductDetail(id: 0, json: HomeADModel(code: "0")),
            ProductDetail(id: 2, json: HomeADModel(code: "2")),
            ProductDetail(id: 3, json: HomeADModel(code: "3")),
            ProductDetail(id: 4, json: HomeADModel(code: "4"))]

var arr2 = [ProductDetail(id: 0, json: HomeADModel(code: "00")),
            ProductDetail(id: 2, json: HomeADModel(code: "22")),
            ProductDetail(id: 3, json: HomeADModel(code: "3")),
            ProductDetail(id: 4, json: HomeADModel(code: "4"))]
arr1.forEach { d in
    print("\(d.id)  \(d.json?.code ?? "nil")")
}
print("-----------")

// 只能单id去重
//arr1.append(contentsOf: arr2)
//arr1 = arr1.deduplication { $0.id }

// contains，会走 ==
arr2.forEach { d in
    if !arr1.contains(d) {
        arr1.append(d)
    }
}

arr1.forEach { d in
    print("\(d.id)  \(d.json?.code ?? "nil")")
}

// MARK: - 创建

var arrR = ["I", "just", "do", "it"]

// MARK: - Inspecting 检查

// isEmpty
print(arrR.isEmpty)

// count
print(arrR.count)

// capacity 容量
print(arrR.capacity)

// MARK: - Accessing Elements 访问元素

// subscript(_:)
print(arrR[1])
print(arrR[2 ..< arrR.endIndex])
print(arrR[2...])

// first
print(arrR.first ?? "0")

// last
print(arrR.last ?? "0")

// randomElement
print(arrR.randomElement() ?? "rand")

// MARK: - Adding Elements 添加元素

// append
arrR.append("china")
print(arrR)

// insert
arrR.insert(".", at: arrR.count)
print(arrR)

let arrInsert = ["Hello", "world"]
arrR.insert(contentsOf: arrInsert, at: arrR.count)
print(arrR)

// replaceSubrange(_:with:)
arrR.replaceSubrange((arrR.endIndex - 1) ..< arrR.endIndex, with: repeatElement("Swift", count: 1))
print(arrR)

// reserveCapacity(_:) 预留足够的空间来存储指定数量的元素。

// MARK: - combining arrays : 组合array

// append + +=
arrR.append(contentsOf: ["iOS"])
arrR += ["apple"]
print(arrR)

// MARK: - removing Elements

// arrR.remove(at: 5)
// arrR.removeLast()
// arrR.removeFirst()
// arrR.removeFirst(2)
// arrR.removeAll()
// arrR.removeSubrange(1 ... 3)
arrR.popLast()
print(arrR)

// MARK: - finding Elements

// contains
let contains1 = arrR.contains("Marlon")
print("contains1 = \(contains1)")

let contains2 = arrR.contains(where: { $0 == "iOS" })
print("contains2 = \(contains2)")

// allSatisfy 满足
print(arrR.allSatisfy { $0 == "iOS" })

// first(where:)
print(arrR.first(where: { $0 == "ios" }) ?? "no find")

// firstIndex
print(arrR.firstIndex(of: "iOS") ?? -1)

// last
print(arrR.last(where: { $0 == "ios" }) ?? "no find")

// lastIndex
print(arrR.lastIndex(of: "iOS") ?? -1)

// min()
let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
let lowestHeight = heights.min()
print(lowestHeight ?? 0)

let hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
let leastHue = hues.min { a, b in a.value < b.value }
print(leastHue ?? 0)

// max()
let greatestHeight = heights.max()
print(greatestHeight ?? Int.max)

let greatestHue = hues.max { a, b in a.value < b.value }
print(greatestHue ?? Int.max)

// MARK: - selecting Elements

// prefix
var numbers = [1, 2, 3, 4, 5]
print(numbers.prefix(2))

if let i = numbers.firstIndex(of: 4) {
    print(numbers.prefix(through: i))
}

if let i = numbers.firstIndex(of: 4) {
    print(numbers.prefix(upTo: i))
}

// suffix
print(numbers.suffix(2))

if let i = numbers.firstIndex(of: 3) {
    print(numbers.suffix(from: i))
}

// MARK: - excluding Elements  将……排除在外

// dropFirst
print(numbers.dropFirst(4))

// dropLast
print(numbers.dropLast(2))

// MARK: - transforming

// map: 返回包含在序列元素上映射给定闭包的结果的数组。
print(arrR.map { $0.uppercased() })

// flatMap: 返回一个数组，该数组包含调用给定变换的结果与该序列的每个元素的连接。
// flatMap可以作为降维使用
let mapped = numbers.map { Array(repeating: $0, count: $0) }
let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
print(mapped)
print(flatMapped)

// compactMap D/ 可以把一个集合中的空值去除，并且返回一个去除nil值得数组
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
print(compactMapped)

// reduce 合并
// initialResult为初始化的值，也是闭包Result第一次运行的值，Element就是要做处理的元素，处理后返回Result作为下次闭包的参数。
// reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result##(_ partialResult: Result, Int) throws -> Result#>)
let numberSum = numbers.reduce(0) { $0 + $1 }
// 简写
let numberSum1 = numbers.reduce(0, +)
print(numberSum)
print(numberSum1)

let reduceArr = [1, 2, 3].reduce("") { $0 + "\($1)" }
print(reduceArr)

// MARK: - iterating 迭代

for word in numbers {
    print(word)
}

numbers.forEach { word in
    print(word)
}

for (n, c) in "Swift".enumerated() {
    print("\(n): '\(c)'")
}

// MARK: - reordering 重排序

var students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
students.sort()
print(students)

students.reversed()

// reversed
print(arrR.reversed())

// sorted
print(arrR.sorted(by: { $0 > $1 }))

// MARK: split : str -> arr

let line = "BLANCHE:   I don't want realism. I want magic!"
print(line.split(separator: " "))
print(line.split(separator: " ", maxSplits: 1))
print(line.split(separator: " ", omittingEmptySubsequences: false))

// jioned :  arr -> str
let strArr = ["I", "just", "do it"]
print(strArr.joined(separator: " "))

// MARK: - - - - -

// 在数组切片中有一点需要注意，数组切片的下标与原始数组中的下标保持一致。如果要取出切片arraySlices中的第一个值，我们要使用arraySlices[3], 而不是arraySlices[0], 如果使用arraySlices[0]就会报错，如下所示：
var sortArr = [1, 3, 4, 5, 7, 8, 10, 39, 23]
// print(subArr[0])

print(sortArr.sorted(by: { $0 < $1 }))
print(sortArr.sorted(by: { $0 > $1 }))

print(sortArr.reversed() as [Int])
let index = sortArr.firstIndex(of: 3)
print(index!)

let array = [["a", "b"], ["c", "d"]]
// 找出包含 d 的那一个数组元素
let index2 = array.firstIndex(where: { $0.firstIndex(of: "d") != nil })
print(index2 ?? 0)

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//: [Next](@next)
