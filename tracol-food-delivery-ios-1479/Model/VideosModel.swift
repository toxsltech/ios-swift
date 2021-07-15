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
class VideosModel: NSObject {
    //MARK:- Variables
    var id = Int()
    var title = String()
    var bannerVideoUrl = String()
    var youTubeLink = String()
    var videoImage = String()

    
    func setDetail(detialDict: NSDictionary){
        title = detialDict["title"] as? String ?? ""
        videoImage = "\(ApiImgUrl.imgUrl)\(detialDict["image_file"] as? String ?? "")"
        bannerVideoUrl = "\(ApiImgUrl.imgUrl)\(detialDict["video_file"] as? String ?? "")"
        youTubeLink = detialDict["youtub_link"] as? String ?? ""
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
    }
}

