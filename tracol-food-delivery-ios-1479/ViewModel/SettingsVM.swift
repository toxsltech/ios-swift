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

class SettingsVM: NSObject {
    // MARK:- API Handling
    func enableNotificationApi(_ request :Int,completion:@escaping() -> Void )  {
        let result = AccountService.userNotification(notificationVal: request).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let dataVal = response?.data!["detail"] as? NSDictionary{
                    objUserModel.setDetail(dataVal)
                    completion()
                }
            }
        }
    }
}
