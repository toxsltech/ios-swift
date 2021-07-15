/**
 *
 *@copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *@author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */
import UIKit
import Alamofire


enum AppInfo {
    static let mode = "development"
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    static let userAgent = "\(mode)/\(appName)/\(version)"
}

enum DeviceInfo{
    static let deviceType = "2"
    static let deviceName = UIDevice.current.name
    static let deviceToken = Proxy.shared.deviceToken()
    
}
enum FontName{
    static let appFont = "Montserrat-Regular"
    static let medium = "Montserrat"
    static let regularSize = UIFont(name: appFont, size: 15)
    static let mediumSize = UIFont(name: appFont, size: 17)
}
var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
}
var baseURL: URL {
    return URL(string: SettingsManager.shared.httpPath)!
}
var methodPost: Alamofire.HTTPMethod { .post }
var methodGet: Alamofire.HTTPMethod { .get }
//var headers: HTTPHeaders? { return ["Authorization": "Bearer \(Proxy.shared.accessNil())","User-Agent":"\(AppInfo.userAgent)"] }
var headers: HTTPHeaders? {
    if Proxy.shared.accessNil() != ""{
    return ["Authorization": "Bearer \(Proxy.shared.accessNil())","User-Agent":"\(AppInfo.userAgent)"]
    }else{
        return nil
    }
}

enum AlertState {
    case success
    case warning
    case info
    case `default`
    case error
}
enum ApiImgUrl {
    static let imgUrl = "https://tracolasia.com" //live url
}
enum AppColor {
    static let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
}
struct ApiResponse {
    var jsonData: Data?
    var data: NSDictionary?
    var message: String?
}
enum ReminderStatus : Int {
    case off = 0, on
}
enum PrayerStatus : Int {
    case audio = 0, text
}
enum PagesConstant:Int{
    case terms = 1, aboutUs,privacyPolicy
    var termsConditonType: String {
        switch self {
        case .terms:
            return "Terms & Conditions"
        case .aboutUs:
            return "About Us"
        case .privacyPolicy:
            return "Privacy Policy"
        }
    }
}
var currency: String {
    return "RM"
}
enum PackajTypeId : Int {
    case product = 1, package
}
var orderStatusUnpaid: String {
    return "Unpaid"
}
var orderStatusPaid: String {
    return "Paid"
}
var whatsAppLink: String {
    return "http://tny.sh/ProgramDietitianSihatTRACOL"
}
var communityLink: String {
    return "https://t.me/tracolasia"
}
var charityLink: String {
    return "https://tracolasia.com/site/charity"
}
