//: [Previous](@previous)

import Foundation

/*
 这一节只要目的是通过自定义一个FIFO(First Input First Output)的集合去了解一些细节。
 Collection是稳定的序列(可多次遍历且保持一致)，可通过下标获取其中的元素。

 知识点1：Collection遵循了Sequence协议。
 知识点2：String，Data，IndexSet也准守了Collection协议。
 知识点3：swift数组可以当做栈 用append入栈，popLast出栈
 注：数组是在连续的内存中持有元素，移除非末尾元素时，后面的元素都会移动填补空白，复杂度为O(n)。
 当你移除数组非末尾元素的时候需要从性能方面去考虑一下。

 队列可以结合使用 push和remove(at:0)
 */

/// 自己写一个最简单的将元素入队和出队的类型
protocol Queue {
    // self中所持有的元素类型
    associatedtype Element
    // 把newElement 加入队列
    mutating func enqueue(_ newElement: Element)
    // 从self出队一个元素
    // 返回值是可选值? 队列为空时这样的做法是安全的
    mutating func dequeue() -> Element?
}

/// 队列的实现 FIFO( First Input First Output)
struct FIFOQueue: Queue {
    fileprivate var left: [Int] = []
    fileprivate var right: [Int] = []

    /// 把元素添加到队尾
    /// 复杂度O(1)
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }

    /// 从队列首部移除一个元素
    /// 队列为nil时候返回空
    /// - 复杂度： 平摊 O(1)
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}


extension FIFOQueue:Collection {

    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count}
    
    public func index(after i: Int) -> Int {
        precondition( i < endIndex)
        return i + 1
    }
    
    public subscript(position: Int) -> Int {
        // precondition precondition(::file:line:) 函数来写先决条件。给这个函数传入表达式计算为 true 或 false ，如果条件的结果是 false 信息就会显示出来
        precondition((0..<endIndex).contains(position),"Index out of bounds")
        if position < left.endIndex{
            return left[left.count - position - 1]
        }else{
            return right[position - left.count]
        }
    }
}

// ExpressibleByArrayLiteral的主要作用是可以让对象支持字面量初始化 那什么是字面量？ (不太知道的同学可以大概瞜一眼菜鸟教程里的解释) 字面量其实就是让你的集合可以用类似[value1, value2, etc]的方式去创建。

extension FIFOQueue:ExpressibleByArrayLiteral{
    ///ExpressibleByArrayLiteral 的init方法去实现一下就ok~
    init(arrayLiteral elements: Int...) {
        self.init(left: elements.reversed(), right: [])
    }
}

// MARK: -  专门的集合类型:Special Collection
/*
 对于collection来说，有两个有意思的限制 1.无法将索引后退移动。 2.没有提供插入，移动，替换元素的功能。 虽然只是有一部分集合可以使用他们，但作为标准库。就只写一些通用的方法。

 //一个既可以前向又可以后向遍历的集合
 BidirectionalCollection
 
 //一个可以高效随机存取索引遍历的集合
 RandomAccessCollection
 
 //一个可以下标赋值的集合
 MutableCollection
 
 //一个可以将任意子范围的元素用别的集合中的元素进行替换的集合
 RangeReplaceableCollection
 
 BidirectionalCollection:
 它提供了sufix()， removeLast() 和 reversed() 几个我们看起来很眼熟的函数很熟悉

 RandomAccessCollection
 和BidirectionalCollection index(_:offsetBy:)```` 去通过渐进的方式去遍历, 相比 RandomAccessCollection 可以 直接在两个索引之间``来移动。 例如计算 startIndex 和 endIndex 的间距。 RandomAccessCollection可以在常数时间内计算出count,相对高效，而其他就会慢很多。

 MutableCollection
 它支持原地的元素更改。 一般的集合只能改变集合的元素值，无法改变集合的长度或元素的顺序。 MutableCollection 只多了一个必须要实现的方法subscript ，而且必须要实现其内部的set方法
 ///协议方法 public subscript(position: Self.Index) -> Self.Element { get set }
 public subscript(position: Element) -> Element {
  get {
 return Element
 }
 set {
 //必须要提供
 }
 }
 知识点1：集合类型 Array Dict Set 中只有Array满足这个协议。

 
 RangeReplaceableCollection
 需要添加或者移除元素可以用这个协议 有两个要求： 1.一个空的初始化方法(在泛型函数中很好用，因为泛型允许一个函数创建相同类型的 新的空集合) 2.replaceSubrange(_:with:)方法 参数为范围和要替换的集合。

 */

//: [Next](@next)
