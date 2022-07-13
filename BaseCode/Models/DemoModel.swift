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

class DemoModel: NSObject {
    
    var id = Int()
    var createdOn = String()
    
    func setDetails(_ details : NSDictionary){
        id = details["id"] as? Int ?? .zero
        
        createdOn = details["created_on"] as? String ?? ""
    }

}
