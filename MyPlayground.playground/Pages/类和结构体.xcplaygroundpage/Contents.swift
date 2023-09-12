//: [Previous](@previous)

import Foundation

/*
 引用类型:
     引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝

 值类型:
     它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制
 */

/*
 Swift 中类和结构体有很多共同点
     定义属性用于存储值
     定义方法用于提供功能
     定义下标操作使得可以通过下标语法来访问实例所包含的值
     定义构造器用于生成初始化值
     通过扩展以增加默认实现的功能
     实现协议以提供某种标准功能

 */

/*
 与结构体相比，类还有如下的附加功能
     继承允许一个类继承另一个类的特征
     类型转换允许在运行时检查和解释一个类实例的类型
     析构器允许一个类实例释放任何其所被分配的资源
     引用计数允许对一个类的多次引用
 */

// 知识点： swift会自动会结构体的成员变量添加初始化方法。
// 在swift5.1以后如果结构体的常量有默认值。 系统会提供有默认值属性和没有默认值属性的两种初始化方法
struct Point {
    var x: Int
    var y: Int
}

// tips: 如若有一个经常使用的结构体值，可以以静态属性定义在扩展内，如下
extension Point {
    static let origin = Point(x: 0, y: 0)
}

Point.origin

let p = Point(x: 1, y: 1)
/// 因为是指语义，所以用let定义结构体变量时，无法去改变变量的属性
// p.x = 10 //error

// 知识点2：
// 结构体的一个属性被赋值时, 它的didSet方法会被调用。
// 被调用的原因: 结构体的某个深层次的属性被改变时，等于是改变了结构体，重新为它赋值。 所以 didSet会被调用。
// 知识点3：在swift中 Array是结构体 当改变数组中某个元素的属性时 数组的didSet也会被调用。

var xPoint = Point(x: 8, y: 0) {
    didSet {
        print("哇哦~我被调用了")
    }
}

xPoint.x = 10 // 哇哦~我被调用了

// 知识点4:struct中如果需要改变self，或者需要改变self中任何属性。 则需要使用mutating 关键字
extension Point {
    mutating func translateY(by offset: Int) {
        /// 这里的y实质上等于是self.y
        y += offset
    }
}

// 知识点5：swift会自动将属性的setter标记为mutating
//
// 知识点6：很多情况下 一个方法会有可变和不可变的区分 如数组的 sort() 是可变方法 sorted() 不可变方法会返回一个新的数组。 // swift中还有很多类似的方法。（感觉这里可以出一个很好的面试题，说说两个方法的区别。）
//
// 了解mutating关键字要先了解inout行为。
// mutating 关键字实质上就是隐式的将self标记成inout了 cool~
// 所以我们就明白为什么 重载 += 左边的参数会被标记成inout了。(划重点 这个可以当成面试题。)

extension Point {
    func triple(x: Int) {
        // x = x * 3 // error x is let
    }

    /// inout 关键字可以将原来的值覆盖
    func triple(x: inout Int) {
        x = x * 3 // ojbk
    }
}

// 5.4写时复制  定义：结构体的引用在改变的一瞬间是唯一的，不会有复制发生，内存的改变将在原地进行。

var x = [1,2,4]
var y = x
x.append(5) //1,2,4,5
y.removeLast() //1,2

// 这时，把x赋值给y时会发生复制。这时候两个数组的引用指向的是内存中的同一个位置。共享存储部分。
// 当改变x时这个共享会被检查到。 内存将会被复制出来。 我们就独立的改变了两个变量。 耗性能的元素复制操作只会在必要的时候发送。这个就叫做写时复制。

// 知识点： 复制结构体变量。里面进行的浅复制。对象本身不会被复制。只有引用会被复制。

// 知识点：结构体的存储位置。
// 默认情况下结构体会存储在堆上，但绝大多数时候swift会对其优化，把结构体存储到栈上。 如果结构体的变量被一个函数闭合（内部使用）了，这个结构体就会存放在堆上。 结构体太大也会被存在堆上

// MARK: - 写时复制的高效方法
// 1.首先要知道一个对象是否是唯一引用的,通过系统提供的isKnownUniquelyReferenced(&obj)函数来获取。
//会返回一个Bool值告诉你是否唯一 对于OC的对象直接返回false
// isKnownUniquelyReferenced(&object: T)
class Box<A> {
    var unbox:A
    init(_ value:A) {
        self.unbox = value
    }
}

var a = Box(NSMutableData())
isKnownUniquelyReferenced(&a)//true
var b = a
isKnownUniquelyReferenced(&a)//false
isKnownUniquelyReferenced(&b)//false

// 2.然后判断为false时执行写是复制(这里详读了一遍感觉比较艰深晦涩，大家可在参考下面的Demo理解)。
struct MyData {
    fileprivate var _data: Box<NSMutableData>
    var _dataForWriting: NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {//检查对_data的引用是否是唯一性
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    init(_ data: NSData) {
        self._data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData {
    mutating func append(_ other: MyData) {
        _dataForWriting.append(other._data.unbox as Data)
    }
}

let someBytes = MyData(NSData(base64Encoded: "wAEP/w==", options: [])!)
var empty = MyData(NSData())
var emptyCopy = empty
for _ in 0..<5 {
    empty.append(someBytes)

}
empty // <c0010fff c0010fff c0010fff c0010fff c0010fff>
emptyCopy // <>



// MARK: - 结构体 数组 修改值

struct MyStruct: CustomDebugStringConvertible {
    var myValue: Int
    var debugDescription: String {
        return "struct is \(myValue)"
    }
}

let struct1 = MyStruct(myValue: 1)
let struct2 = MyStruct(myValue: 2)
let structArray = [struct1, struct2]

let newStructArray = structArray.map { myStruct -> MyStruct in
    // You can check anything like:
    if myStruct.myValue == 1 {
        var modified = myStruct
        modified.myValue = 0
        return modified
    } else {
        return myStruct
    }
}

debugPrint(newStructArray)

//: [Next](@next)
