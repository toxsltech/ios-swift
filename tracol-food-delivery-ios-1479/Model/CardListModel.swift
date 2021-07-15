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
class CardListModel: NSObject {
    //MARK:- Variables
    var id = String()
    var name = String()
    var cardBrand = String()
    var cardNumber = Int()
    var cardExpiryMonth = String()
    var cardExpiryYear = String()

    func setDetail(detialDict: NSDictionary){
        id = detialDict["id"] as? String ?? ""

      // id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        name = detialDict["name"] as? String ?? ""
        cardBrand = detialDict["brand"] as? String ?? ""
        cardNumber = Proxy.shared.getIntegerValue(detialDict["last4"] as Any)
        cardExpiryMonth = detialDict["exp_month"] as? String ?? ""
        cardExpiryYear = detialDict["exp_year"] as? String ?? ""

        
        
    }
}

