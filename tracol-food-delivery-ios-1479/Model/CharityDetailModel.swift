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
var objCharityDetailModel = CharityDetailModel()
class CharityDetailModel {
    //MARK:- Variables
    var id = Int()
    var title = String()
    var charityImg = String()
    var miniAmount = Int()
    var maxAmount = Int()
    var description =  String()
    var goalAmount = Int()
    var raisedAmount = String()
    var shareUrl =  String()

    
    var controller = UIViewController()
    
    func setDetail(_ detail: NSDictionary)  {
        Proxy.shared.clearChache()
        id = Proxy.shared.getIntegerValue(detail["id"] as Any)
        title = detail["title"] as? String ?? ""
        charityImg = "\(ApiImgUrl.imgUrl)\(detail["image_file"] as? String ?? "")"
       miniAmount = Proxy.shared.getIntegerValue(detail["max_amount"] as Any)
        maxAmount = Proxy.shared.getIntegerValue(detail["min_amount"] as Any)
        goalAmount = Proxy.shared.getIntegerValue(detail["goal_amount"] as Any)
        raisedAmount = detail["raised_amount"] as? String ?? ""
        description = (detail["description"] as? String ?? "").removeHtmlTags
        shareUrl = "\(ApiImgUrl.imgUrl)\(detail["url"] as? String ?? "")"
    }
}

