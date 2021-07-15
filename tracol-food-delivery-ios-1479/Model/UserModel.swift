//
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
var objUserModel = UserModel()
class UserModel {
    //MARK:- Variables
    var firstName = String()
    var lastName = String()
    var fullName = String()
    var email = String()
    var phoneNumber = String()
    var latitude = String()
    var longitude = String()
    var address = String()
    var city = String()
    var country = String()
    var gender = Int()
    var genderTitle = String()
    var rating = Double()
    var profilePic = String()
    var userId = Int()
    var notificationStatus = Int()
    var descriptionVal = String()
    var experiences = Int()
    var isSetDefaultCard = Int()
    var defaultCardId  = String()
    var aboutMe =  String()
    var isVerified = Int()
    var isProfileComplete = Int()
    var subscriptionId = Int()
    var deliveryCharges = 24
    
    var controller = UIViewController()
    
    func setDetail(_ detail: NSDictionary)  {
        Proxy.shared.clearChache()
        isVerified =  Proxy.shared.getIntegerValue(detail["is_verified"] as Any)
        latitude = detail["latitude"] as? String ?? ""
        aboutMe = detail["about_me"] as? String ?? ""
        longitude = detail["longitude"] as? String ?? ""
        profilePic = detail["profile_file"] as? String ?? ""
        profilePic = "\(ApiImgUrl.imgUrl)\(detail["profile_file"] as? String ?? "")"
        firstName = detail["first_name"] as? String ?? ""
        lastName = detail["last_name"] as? String ?? ""
        fullName = detail["full_name"] as? String ?? ""
        city = detail["city"] as? String ?? ""
        country = detail["country"] as? String ?? ""
        email = detail["email"] as? String ?? ""
        phoneNumber = detail["contact_no"] as? String ?? ""
        address = detail["address"] as? String ?? ""
        gender =  Proxy.shared.getIntegerValue(detail["gender"] as Any)
        genderTitle = gender == 1 ? "Male" :  gender == 2 ? "Female" : ""
        userId = Proxy.shared.getIntegerValue(detail["id"] as Any)
        notificationStatus = Proxy.shared.getIntegerValue(detail["notification_status"] as Any)
        rating =  detail["rating"] as? Double ?? 0.0
        isSetDefaultCard = Proxy.shared.getIntegerValue(detail["is_default"] as Any)
        isProfileComplete = Proxy.shared.getIntegerValue(detail["is_profile_complete"] as Any)
        if let userDetailDict = detail["userDetail"] as? NSDictionary {
            subscriptionId = Proxy.shared.getIntegerValue(userDetailDict["subscription_id"] as Any)
        }
    }
}

