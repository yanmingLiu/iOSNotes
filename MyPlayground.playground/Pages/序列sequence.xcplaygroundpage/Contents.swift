//: [Previous](@previous)

import Foundation

/*
 知识点1：想要创建一个自定义的序列 只要遵循sequence协议。并实现makeIterator方法。
 makeIterator方法的返回值是遵循IteratorProtocol的迭代器(是一个自定义类或者结构体)。
 这样来说一个自定义序列的构建过程就是这样的 Iterator->Sequence->集合

 迭代器：Iterator

 里面只有一个方法next( )
 注：迭代器是单向结构，只能按照增加的方向前进，不能倒退或者重置。

 public protocol IteratorProtocol {
     ///迭代器产生的值的类型
     ///如 subViews的迭代原生类型就是View 可以不用写，编译器根据next()的返回值自动判断。
     associatedtype Element
     ///你只需要在每次调用的时候返回下一个值，结束时返回nil
     public mutating func next() -> Self.Element?
 }

 下面我们通过一个打印一个字符串所有前缀的demo 通过自定义迭代器IteratorProtocol和自定义集合Sequence去写一个属于你的集合~

 */

// 第一步: 创建一个迭代器(Iterator)

struct PrefixStrIterator: IteratorProtocol {
    var string: String
    var offset: String.Index
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }

    /// 写协议方法
    mutating func next() -> String? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return String(string[string.startIndex ..< offset])
    }
}

// 第二步: 创建一个使用这个迭代器的序列(sequence)
/// step2.创建一个属于你的集合
struct PrefixSequence: Sequence {
    var string: String

    /// 协议方法：返回一个迭代器
    func makeIterator() -> PrefixStrIterator {
        return PrefixStrIterator(string: string)
    }
}

/// myfirstSquence 我的第一个集合
for prefixStr in PrefixSequence(string: "Hi~LiaoWorking!") {
    print(prefixStr)
//            H
//            Hi
//            Hi~
//            Hi~L
//            Hi~Li
//            Hi~Lia
//            Hi~Liao
//            Hi~LiaoW
//            Hi~LiaoWo
//            Hi~LiaoWor
//            Hi~LiaoWork
//            Hi~LiaoWorki
//            Hi~LiaoWorkin
//            Hi~LiaoWorking
//            Hi~LiaoWorking!
}

/*
继续写一个Demo：
 AnyIterator还有一个初始化方法就是直接接受next()函数来当做参数。
 然后通过引用语义的特性，我们可以不创建新的类型就写一个斐波那契迭代器
*/
/// 通过引用语义的特性写斐波那契
func fibsIterator() -> AnyIterator<Any> {
    var startNum = (0, 1)
    return AnyIterator{
        let nextNum = startNum.0
            startNum = (startNum.1 , startNum.0 + startNum.1)
        return nextNum
    }
}


//: [Next](@next)
