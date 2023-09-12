//: [Previous](@previous)

import UIKit
import Foundation

/*
 当除label外的参数都使用默认值时，初始化方法返回的便是串行队列。
 如果需要返回并发队列，参数attributes传值为.concurrent即可。
 DispatchQueue.Attributes
 是一个结构体类型，该结构体提供了两个静态变量：concurrent和initiallyInactive(注意，没有代表串行队列的静态变量)。如果attributes参数传值为initiallyInactive, 任务不会自动执行，而是需要开发者手动调用activate()触发。但是代码依然是串行进行的,如果想要手动触发、并行执行任务,
 可以指定attributes参数接受一个数组: [.concurrent, .initiallyInactive]。

 参数qos代表队列执行的优先级，有六种优先级可供选择：
 unspecified
 background
 default
 utility
 userInteractive
 userInitiated

 优先级从高到低依次为userInteractive>userInitiated>utility>background,
 而default与unspecified介于userInteractive与background之间，具体有系统决定。

 */

let group = DispatchGroup()

//let queue = DispatchQueue(label: "concurrenceQueue", qos: .default, attributes: .concurrent)

let queue = DispatchQueue.global()

group.enter()
queue.async(group: group) {
    print("任务一")
    group.leave()
};

group.enter()
queue.async(group: group) {
    print("任务二")
    group.leave()
};

group.enter()
queue.async(group: group) {
    print("任务3")
    group.leave()
};

group.enter()
queue.async(group: group) {
    print("任务4")
    group.leave()
};

group.notify(queue: .main) {
    print("所有任务结束 \(Thread.current)")
}

group.enter()
queue.async(group: group) {
    print("任务5")
    group.leave()
};



//: [Next](@next)
