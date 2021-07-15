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
class NotficationListModel: NSObject {
    //MARK:- Variables
    var id = Int()
    var modelId = Int()
    var typeId = Int()
    var title = String()
    var createdOn = String()
    var date = String()
    
    func setDetail(detialDict: NSDictionary){
        title = detialDict["title"] as? String ?? ""
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        modelId = Proxy.shared.getIntegerValue(detialDict["model_id"] as Any)
        typeId = Proxy.shared.getIntegerValue(detialDict["type_id"] as Any)
        createdOn = detialDict["created_on"] as? String ?? ""
        if let dateValue = detialDict["created_on"] as? String {
            date = Proxy.shared.dateConvertDay(date: dateValue, dateFormat: "yyyy-MM-dd HH:mm:ss", getFormat: "dd MMM | h:mm a" )
        } else {
            date =  ""
        }
    }
}
