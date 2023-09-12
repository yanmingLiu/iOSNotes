//: [Previous](@previous)

import Foundation

/*

 策略模式[1-5]定义了一系列的算法，并将每一个算法封装起来，使它们可以相互替换。策略模式通常包含以下角色：

 抽象策略（Strategy）类：定义了一个公共接口，各种不同的算法以不同的方式实现这个接口，环境角色使用这个接口调用不同的算法，一般使用接口或抽象类实现。
 具体策略（Concrete Strategy）类：实现了抽象策略定义的接口，提供具体的算法实现。
 环境（Context）类：持有一个策略类的引用，最终给客户端调用。

 适配器模式[1-5]：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类能一起工作。适配器模式包含以下主要角色：

 目标（Target）接口：当前系统业务所期待的接口，它可以是抽象类或接口。
 适配者（Adaptee）类：它是被访问和适配的现存组件库中的组件接口。
 适配器（Adapter）类：它是一个转换器，通过继承或引用适配者的对象，把适配者接口转换成目标接口，让客户按目标接口的格式访问适配者。

 单例模式[1-5]设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

 这种模式涉及到一个单一的类，该类负责创建自己的对象，同时确保只有单个对象被创建。这个类提供了一种访问其唯一的对象的方式，可以直接访问，不需要实例化该类的对象。

 */

enum RewardType: String {
    case Waimai
    case Hotel
    case Food
    case wood
}

// 奖励服务
class RewardService {
    public func issueReward(rewardType: RewardType, params: String) {
        switch rewardType {
            case .Waimai:
                print("外卖策略:\(params)")

            case .Hotel:
                print("酒旅策略:\(params)")

            case .Food:
                print("美食策略:\(params)")

            case .Food:
                    print("wood策略:\(params)")

            default:
                print("没有奖励")
        }
    }
}

let service = RewardService()
service.issueReward(rewardType: .Hotel, params: "五星级")

/*
 这段代码有两个主要问题，
 一是不符合开闭原则，可以预见，如果后续新增品类券的话，需要直接修改主干代码，而我们提倡代码应该是对修改封闭的；
 二是不符合迪米特法则，发奖逻辑和各个下游接口高度耦合，这导致接口的改变将直接影响到代码的组织，使得代码的可维护性降低。
 */

// 策略接口
protocol Strategy {
    func issue(params: String)
}

// 外卖策略
class Waimai: Strategy {
    func issue(params: String) {
        print("外卖策略:\(params)")
    }
}

// 酒旅策略
class Hotel: Strategy {

    func issue(params: String) {
        print("酒旅策略:\(params)")
    }
}

// 美食策略
class Food: Strategy {
    func issue(params: String) {
        print("美食策略:\(params)")
    }
}

// wood策略
class Wood: Strategy {
    func issue(params: String) {
        print("wood策略:\(params)")
    }
}

// 策略上下文，用于管理策略的注册和获取
class StrategyContext {
    static var shared = StrategyContext()
    private init() {}

    private var registerMap = [String: Strategy]()

    // 注册策略
    func registerStrategy(rewardType: String, strategy: Strategy) {
        registerMap[rewardType] = strategy
        print("注册策略: \(rewardType) \(strategy)")
    }

    // 获取策略
    func getStrategy(rewardType: String) -> Strategy? {
        return registerMap[rewardType]
    }
}

// 优化后的策略服务
class RewardService2 {
    init() {
        StrategyContext.shared.registerStrategy(rewardType: RewardType.Waimai.rawValue, strategy: Waimai())
        StrategyContext.shared.registerStrategy(rewardType: RewardType.Hotel.rawValue, strategy: Hotel())
        StrategyContext.shared.registerStrategy(rewardType: RewardType.Food.rawValue, strategy: Food())
        StrategyContext.shared.registerStrategy(rewardType: RewardType.wood.rawValue, strategy: Wood())
    }

    public func issueReward(rewardType: String, params: String) {
        let strategy = StrategyContext.shared.getStrategy(rewardType: rewardType)
        strategy?.issue(params: params)
    }
}

let service2 = RewardService2()
service2.issueReward(rewardType: RewardType.wood.rawValue, params: "五星级2")

//: [Next](@next)
