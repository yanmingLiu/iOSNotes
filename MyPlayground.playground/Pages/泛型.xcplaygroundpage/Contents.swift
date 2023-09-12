//: [Previous](@previous)

import Foundation
import UIKit

// https://github.com/Liaoworking/Advanced-Swift/blob/master/%E7%AC%AC%E4%B9%9D%E7%AB%A0%EF%BC%9A%E6%B3%9B%E5%9E%8B/9.1%20%E9%87%8D%E8%BD%BD%20Overloading.md
//MARK: - 重载 Overloading

/// 泛型打印view的相关信息
///
/// - Parameter view: view
func log<View: UIView>(_ view: View) {
    print("It's a \(type(of: view)), frame: \(view.frame)")
}

///对泛型的重写
func log(_ view: UILabel) {
    let text = view.text ?? "(empty)"
    print("It's a label, text: \(text)")
}

let label = UILabel(frame: .zero)
label.text = "liaoworking is handsome~~"
let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 101))

log(label) //It's a label, text: liaoworking is handsome~~
log(button) //It's a UIButton, frame: (0.0, 0.0, 100.0, 101.0)

let views = [label, button] // Type of views is [UIView] for view in views {

for view in views {
    log(view)
}
/*
 It's a UILabel, frame: (20.0, 20.0, 200.0, 32.0)
 It's a UIButton, frame: (0.0, 0.0, 100.0, 50.0)
 咦~为嘛在for循环中就无法去区分方法了? 原因：泛型的重载在编译时期就确定的。并不是在runtime时候动态确定。 就会有上面的差异。 觉得疑惑的同学可以长按键盘的option，然后用鼠标点一下 views，xcode的类型提示也会给你答案。

 */


//MARK: -  运算符的重载 Overload Resolution for Operators
// 封装一个幂运算的方法


//: [Next](@next)
