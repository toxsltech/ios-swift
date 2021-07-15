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

class ForgotPasswordVM: NSObject {
    // MARK:- API Handling
    func forgotPasswordApi(_ request : ForgotPasswordRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.forgotPassword(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    completion()
                    Proxy.shared.displayStatusCodeAlert(AlertMessage.forgotPassword)
                }
            }
        }
    }
    // MARK:- Validation Handling
    func validData(_ request: ForgotPasswordRequest) -> Bool {
        if (request.email?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.email)
        }else if !Proxy.shared.isValidEmail(request.email!){
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validEmail)
        }else{
            return true
        }
        return false
    }
}
