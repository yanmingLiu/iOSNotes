//: [Previous](@previous)

import Foundation

// MARK: - 内存

// 1. weak 引用 知识点： delegate 用 weak关键字修饰（同OC）

// 2. unowned 引用 作用：不持有引用对象，但这个属性会一直有效(意思就是unowned 修饰的属性一定要是不为nil的)
// 如果确实一定有值，这个属性就不应该是可选值，这个时候可以用unowned关键字。

/*
 实际项目中如果对unowned 和weak 拿捏的不太准的话鼎力推荐使用weak ！！！,
 我们项目里面已经没有unowned self 这样的用法了。
 我之前项目中一直的一个崩溃就是 用[unwoned self] 修饰self 但self可能为nil。 导致直接崩溃。
 */


// MARK: - autoclosure 自动闭包
/*
解释： @autoclosure把一个很长的表达式直接自动闭合一个简单的闭包，让你的闭包看起来很简洁。自动闭包没有参数。你添加参数编译器就会报错。
知识点1：
短路求值 ：像&&和||操作符中， 只要左边不符合条件或者符合条件就直接忽略（短路掉）右边的操作数。
*/
///这里我们依赖了短路求值， 第一个操作数不符合要求时候直接不走对应的逻辑代码
let evens = [2, 4, 6]
if !evens.isEmpty && evens[0] > 10  {
        //do something
}

// MARK: - @escaping（逃逸闭包的标注） 标注
/*
 知识点1：闭包作为参数默认都是非逃逸闭包。
 注：一句话介绍@escaping的作用就是延长闭包作为参数时候的生命周期。
 注2： 一般在项目中网络请求的回调用作为闭包时 系统就会强制添加闭包参数加@escping标注。
 相信swift开发者在项目中肯定用（被系统强制用）过@escaping标注。 这里就不赘述了。
 */


// MARK: - 错误处理  rethrows Rethrows

// rethrows关键字作用： 告诉编译器，这个函数只会在它的参数函数抛错时抛错 编译器可以避免我们一定要用try调用。
//总结：throw在函数或者方法中抛出异常，让调用者必须明确地处理可能的异常，
//     rethrows本身并不抛出异常或者处理异常，其只起到传递异常的作用

// defer关键字的作用：实际是一个闭包，在当前声明的作用域结束时执行。
var counter = 5
func increment() -> Int {
    defer { counter += 1 }
    return counter
}
counter = increment()
print(counter)
// 可能大部分童鞋都能把答案猜对，但其中具体的原因可能还真不是你想的那样哈哈~ 具体的思路见网页： https://www.objc.io/quiz/19/


//: [Next](@next)
