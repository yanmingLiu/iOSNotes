//: [Previous](@previous)

import Foundation

var a = [3, 2, 1, 4, 5, 0, 6, 7, 8, 9]


let startTime = CFAbsoluteTimeGetCurrent()
print(a.sorted(by: < ))
let endTime = CFAbsoluteTimeGetCurrent()
print("sorted ：%f 毫秒", (endTime - startTime)*1000)

// 快速排序  >  插入排序  > 选择排序  >  冒泡排序

// MARK: - 冒泡排序
// 算法思想:
/*
将被排序的记录数组R[1..n]垂直排列，每个记录R[i]看作是重量为R[i].key的气泡。
根据轻气泡不能在重气泡之下的原则，从下往上扫描数组R：凡扫描到违反本原则的轻气泡，就使其向上”飘浮”。
如此反复进行，直到最后任何两个气泡都是轻者在上，重者在下为止。（不管轻者在上，还是重者在上，原理都一样）
*/

public extension Array where Element: Comparable {
    mutating func bubbleSort() -> Array {
        let count = self.count
        for i in 0..<count {
            for j in 0..<(count - 1 - i) {
                if self[j] > self[j + 1] {
                    (self[j], self[j + 1]) = (self[j + 1], self[j])
                }
            }
        }
        return self
    }
}

let startTime1 = CFAbsoluteTimeGetCurrent()
print(a.bubbleSort())
let endTime1 = CFAbsoluteTimeGetCurrent()
print("bubbleSort ：%f 毫秒", (endTime1 - startTime1)*1000)

// MARK: - 插入排序
// 算法思想: 利用顺序查找实现“在 R[1..i-1]中查找 R[i]的插入位置”的插入排序。

public extension Array where Element: Comparable {
    mutating func insertionSort() -> Array {
        let count = self.count
        guard count > 1 else { return self }
        for i in 1..<count {
            var j = i - 1
            let temp = self[i]
            //與已排序的數逐一比較，大於temp時，該數向後移
            while j >= 0, self[j] > temp {
                self[j + 1] = self[j]
                j -= 1
            }
            // 被排序数放到正确的位置
            self[j + 1] = temp
        }
        return self
    }
}

let startTime2 = CFAbsoluteTimeGetCurrent()
print(a.insertionSort())
let endTime2 = CFAbsoluteTimeGetCurrent()
print("insertionSort ：%f 毫秒", (endTime2 - startTime2)*1000)

// MARK: - 选择排序
/*
 算法描述：

 比如在一个长度为N的无序数组中，
 在第一趟遍历N个数据，找出其中最小的数值与第一个元素交换，
 第二趟遍历剩下的N-1个数据，找出其中最小的数值与第二个元素交换……第N-1趟遍历剩下的2个数据，找出其中最小的数值与第N-1个元素交换，至此选择排序完成。
 */
public extension Array where Element: Comparable {
    mutating func selectionSort() -> Array {
        let count = self.count
        for i in 0..<count {
            var minIndex = i
            for j in (i + 1)..<count {
                if self[j] < self[minIndex] {
                    minIndex = j
                }
            }
            (self[i], self[minIndex]) = (self[minIndex], self[i])
        }
        return self
    }
}

let startTime3 = CFAbsoluteTimeGetCurrent()
print(a.selectionSort())
let endTime3 = CFAbsoluteTimeGetCurrent()
print("selectionSort ：%f 毫秒", (endTime3 - startTime3)*1000)

// MARK: - 快速排序
/*
 算法思想：
 找一个记录，以它的关键字作为“枢轴”，凡其关键字小于枢轴的记录均移动至该记录之前，反之，凡关键字大于枢轴的记录均移动至该记录之后。
 致使一趟排序之后，记录的无序序列 R[s..t]将分割成两部分：R[s..i-1]和R[i+1..t],
 且 R[j].key≤ R[i].key ≤ R[t].key (s≤j≤i-1) 枢轴(i+1≤j≤t)。
 */

public extension Array where Element: Comparable {
    mutating func quickSort(left: Int, right: Int) -> Array {
        guard left < right else { return self}
        var i = left + 1, j = left
        let key = self[left]
        while i <= right {
            if self[i] < key {
                j += 1
                (self[i], self[j]) = (self[j], self[i])
            }
            i += 1
        }
        (self[left], self[j]) = (self[j], self[left])
        quickSort(left: j + 1, right: right)
        quickSort(left: left, right: j - 1)
        return self
    }
}

let startTime4 = CFAbsoluteTimeGetCurrent()
print(a.quickSort(left: 0, right: a.count - 1))
let endTime4 = CFAbsoluteTimeGetCurrent()
print("quickSort ：%f 毫秒", (endTime4 - startTime4)*1000)

// MARK: -  随机快排

public extension Array where Element: Comparable {
    mutating func randomQuickSort(left: Int, right: Int) -> Array {
        guard left < right else { return self }
        let randomIndex = Int.random(in: left...right)
        (self[left], self[randomIndex]) = (self[randomIndex], self[left])
        var i = left + 1, j = left
        let key = self[left]
        while i <= right {
            if self[i] < key {
                j += 1
                (self[i], self[j]) = (self[j], self[i])
            }
            i += 1
        }
        (self[left], self[j]) = (self[j], self[left])
        randomQuickSort(left: j + 1, right: right)
        randomQuickSort(left: left, right: j - 1)
        return self
    }
}

let startTime5 = CFAbsoluteTimeGetCurrent()
print(a.randomQuickSort(left: 0, right: a.count - 1))
let endTime5 = CFAbsoluteTimeGetCurrent()
print("randomQuickSort ：%f 毫秒", (endTime5 - startTime5)*1000)

// MARK: -  双路快排

public extension Array where Element: Comparable {
    mutating func quickSort2(left: Int, right: Int) -> Array {
        guard left < right else { return self }
        let randomIndex = Int.random(in: left...right)
        (self[left], self[randomIndex]) = (self[randomIndex], self[left])
        var l = left + 1, r = right
        let key = self[left]
        while true {
            while l <= r, self[l] < key {
                l += 1
            }
            while l < r, key < self[r] {
                r -= 1
            }
            if l > r { break }
            (self[l], self[r]) = (self[r], self[l])
            l += 1
            r -= 1
        }
        (self[r], self[left]) = (self[left], self[r])
        quickSort(left: r + 1, right: right)
        quickSort(left: left, right: r - 1)
        return self
    }
}

let startTime6 = CFAbsoluteTimeGetCurrent()
print(a.quickSort2(left: 0, right: a.count - 1))
let endTime6 = CFAbsoluteTimeGetCurrent()
print("quickSort2 ：%f 毫秒", (endTime6 - startTime6)*1000)

// MARK: - 三路快排

public extension Array where Element: Comparable {
    mutating func quickSort3(left: Int, right: Int) -> Array {
        guard left < right else { return self }
        let randomIndex = Int.random(in: left...right)
        (self[left], self[randomIndex]) = (self[randomIndex], self[left])
        var lt = left, gt = right
        var i = left + 1
        let key = self[left]
        while i <= gt {
            if self[i] == key {
                i += 1
            } else if self[i] < key {
                (self[i], self[lt + 1]) = (self[lt + 1], self[i])
                lt += 1
                i += 1
            } else {
                (self[i], self[gt]) = (self[gt], self[i])
                gt -= 1
            }
        }
        (self[left], self[lt]) = (self[lt], self[left])
        quickSort(left: gt + 1, right: right)
        quickSort(left: left, right: lt - 1)
        return self
    }
}

let startTime7 = CFAbsoluteTimeGetCurrent()
print(a.quickSort3(left: 0, right: a.count - 1))
let endTime7 = CFAbsoluteTimeGetCurrent()
print("quickSort3 ：%f 毫秒", (endTime7 - startTime7)*1000)

//: [Next](@next)
