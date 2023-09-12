//: [Previous](@previous)

import Foundation



// String的lexicographicallyPrecedes方法在项目中挺实用的，是swift标准库自带方法，像比较时间字符串"2018-08-08" 和 "2018-03-04" 的时间先后就可以用这个方法。
// 会按照顺序比较两个集合元素的大小。大概意思是说 判断两个参数按照字典排序的顺序
// 知识点：swift中的排序算法是基于内省算法（introsort），起实质是快排和堆排的混合。 当集合很小时会转化为插入排序。避免不必要的性能消耗。



let date1 = "2018-08-08"
let date2 = "2018-03-04"

let res = date1.lexicographicallyPrecedes(date2)
print("date1 < date2 = \(res)") // fase

let a = [1,2,1]
let b = [1,2,2]

let res2 = a.lexicographicallyPrecedes(b)
print("a < b = \(res2)")


extension NSNumber {
    /// 显示k数量
    /// - Returns: xxx.xK
    func displayCount() -> String {
        if doubleValue <= 0 {
            return "0"
        }
        if doubleValue < 1000 {
            return description
        }
        if doubleValue >= 999999 {
            return "99.9K"
        }
        let result = doubleValue / 1000.0
        let num1 = NSNumber(value: result)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.roundingMode = .down
        numberFormatter.positiveSuffix = "K"
        numberFormatter.positiveFormat = "#0.0"
        return numberFormatter.string(from: num1)!
    }
}

var a2:NSNumber = NSNumber(value: 999999)
let str = a2.displayCount()
print("\(str)")

//: [Next](@next)
