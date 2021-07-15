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
class BannersImagesModel {
    //MARK:- Variables
    var title = String()
    var bannerImg = String()
    var id = Int(),userId = Int()
    
    func setDetail(detialDict: NSDictionary)  {
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        userId = Proxy.shared.getIntegerValue(detialDict["created_by_id"] as Any)
        title = (detialDict["title"] as? String ?? "").removeHtmlTags
        //bannerImg = detialDict["image_file"] as? String ?? ""
        bannerImg = "\(ApiImgUrl.imgUrl)\(detialDict["image_file"] as? String ?? "")"
    }
}
