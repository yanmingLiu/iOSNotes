//: [Previous](@previous)

import Foundation

// MARK: - Welcome
struct User<T: Codable>: Codable {
    var loginStatus: Int?
    var socialList: [T]?
    var thirdType: String?
    var userContent: String?
    var score: String?
    var userFavorite: Bool?
    var birthdayWishes: Bool?
    var userLanguages: [UserLanguage]?
    var acceptRecommendedSwitch: Bool?
    var matchGrabOrderEnabled: Bool?
    var sex: Int?
    var gmtId: Int?
    var accountType: Int?
    var takeAnOrder: Bool?
    var appleUserIsChangeBind: Bool?
    var userLevelExperience: Int?
    var isBlock: String?
    var medalCount: Int?
    var merchantLevelScore: Int?
    var topLabel: Bool?
    var headImg: String?
    var legends: Bool?
    var followedStatus: String?
    var merchantTopListHideEnabled: Bool?
    var userId: Int?
    var authStatus: Int?
    var muteTime: String?
    var registerType: String?
    var topListHideEnabled: Bool?
    var birthDayStr: String?
    var accountRuleType: String?
    var adult: Bool?
    var coloredNickName: Bool?
    var completeGuide: Bool?
    var memberType: String?
    var onlineStatus: String?
    var userAvatarFrame: String?
    var incognitoAccess: Bool?
    var country: String?
    var chatRoomInviteInform: Bool?
    var customerRecommendEnabled: Bool?
    var isSubscribeMerchant: Bool?
    var buyerGuardianEnabled: Bool?
    var liveIsSync: Bool?
    var roleType: String?
    var email: String?
    var notRecommendedEnabled: Bool?
    var onlineRemindEnabled: Bool?
    var modifyUserInfo: Bool?
    var epalsRecommendEnabled: Bool?
    var passwordSet: Bool?
    var realtimeOnlineStatus: Int?
    var merchantSubscribeStatus: String?
    var social: String?
    var age: Int?
    var topEpalLabel: Bool?
    var gmtName: String?
    var topicsCount: Int?
    var userLevel: String?
    var officialUnion: Bool?
    var isShowLive: Bool?
    var followingCount: Int?
    var merchantLevel: String?
    var mute: Bool?
    var freeCharge: Int?
    var nickname: String?
    var creator: Bool?
    var catName: String?
    var authAuditTime: Int?
    var emailPushEnabled: Bool?
    var gmt: String?
    var createTimeStr: String?
    var regionName: String?
    var followedEachOther: String?
    var idCard: String?
    var visitedCount: Int?
    var createTime: Int?
    var mobile: String?
    var birthdayVisibleEnabled: Bool?
    var followedCount: Int?
    var accountStatus: Int?
    var sellerGuardianEnabled: Bool?
    var imSoundStatus: Int?
    var account: String?

}

// MARK: - SocialList
struct SocialList: Codable {
    var index: Int?
    var type: String?
    var url: String?
    var delete: Bool?
}

// MARK: - UserLanguage
struct UserLanguage: Codable {
    var createTime: Int?
    var id: Int?
    var languageId: Int?
    var languageName: String?
    var userId: Int?
    var editTime: Int?
}

let person = try JSONDecoder().decode(User<SocialList>.self, from: json.data(using: .utf8)!)
print(person.nickname)
print(person.userLanguages?.map({$0.languageName}))
print(person.socialList?.first?.url ?? "")
//: [Next](@next)
