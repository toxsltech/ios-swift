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
class CountryListModel: NSObject {
    //MARK:- Variables
    var id = Int()
    var name = String()
    
    func setDetail(detialDict: NSDictionary){
        name = detialDict["name"] as? String ?? ""
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
    }
}

