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
class AddressListModel: NSObject {
    
    //MARK:- Variables
    var id = Int()
    var address = String()
    var bannerVideoUrl = String()
    var zipcode = String()
    var contactNo = String()
    var isDefault = Int()
    var secondaryAddress = String()
    var city = String()

    func setDetail(detialDict: NSDictionary){
        city = detialDict["city"] as? String ?? ""
        secondaryAddress = detialDict["secondary_address"] as? String ?? ""
        address  = detialDict["primary_address"] as? String ?? ""
        contactNo  = Proxy.shared.getStringValue(detialDict["contact_no"] as Any)
        bannerVideoUrl = "\(ApiImgUrl.imgUrl)\(detialDict["video_file"] as? String ?? "")"
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        isDefault = Proxy.shared.getIntegerValue(detialDict["is_default"] as Any)
        zipcode = detialDict["zipcode"] as? String ?? ""
    }
}

