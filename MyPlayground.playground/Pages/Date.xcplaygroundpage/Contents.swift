//: [Previous](@previous)

import Foundation

let s = 946656000000

let is10 = (String(s).count == 10)
let is13 = (String(s).count == 13)


print(is10)
print(is13)

func timeStampToCurrentTime(_ timeStamp: Int) -> String {
    
    let currentTime = Date().timeIntervalSince1970
    let timeSta: TimeInterval = TimeInterval(timeStamp / 1000)
    let reduceTime: TimeInterval = currentTime - timeSta
    
    if reduceTime < 60 {
        return "刚刚"
    }
    // 时间差大于一分钟小于60分钟内
    let mins = Int(reduceTime / 60)
    if mins < 60 {
        return "\(mins)分钟前"
    }
    // 时间差大于一小时小于24小时内
    let hours = Int(reduceTime / 3600)
    if hours < 24 {
        return "\(hours)小时前"
    }
    // 时间差大于一天小于30天内
    let days = Int(reduceTime / 3600 / 24)
    if days < 30 {
        return "\(days)天前"
    }
    // 不满足以上条件直接返回日期
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmatter = DateFormatter()
    dfmatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dfmatter.string(from: date as Date)
}



let str = timeStampToCurrentTime(Int(s))

print(str)

//: [Next](@next)
