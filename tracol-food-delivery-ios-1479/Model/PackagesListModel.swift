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
class PackagesListModel: NSObject {
    //MARK:- Variables
    var id = Int()
    var title = String()
    var amount = Int()
    var packageImage = String()
    var discription = String()
    var quantity = Int()
    var favourite = Int()
    var typeId = Int()
    func setDetail(detialDict: NSDictionary){
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        title = detialDict["title"] as? String ?? ""
        packageImage = "\(ApiImgUrl.imgUrl)\(detialDict["image_file"] as? String ?? "")"
        quantity = Proxy.shared.getIntegerValue(detialDict["quantity"] as Any)
        favourite = Proxy.shared.getIntegerValue(detialDict["is_favourite"] as Any)
        typeId = Proxy.shared.getIntegerValue(detialDict["type_id"] as Any)
        discription = (detialDict["description"] as? String ?? "").removeHtmlTags
        amount = Proxy.shared.getIntegerValue(detialDict["amount"] as Any)
    }
}

