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

class ChangePasswordVM: NSObject {
    // MARK:- API Handling
    func changePasswordApi(_ request : ChangePasswordRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.changePassword(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    objUserModel = UserModel()
                    UserDefaults.standard.set("", forKey: "access-token")
                    UserDefaults.standard.synchronize()
                    completion()
                    Proxy.shared.displayStatusCodeAlert(AlertMessage.passwordChangeSuccss)
                }
            }
        }
    }
    
    // MARK:- Validation Handling
    func validData(_ request: ChangePasswordRequest) -> Bool {
        if (request.newPassword?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.newPassword)
        }else if request.newPassword!.count < 8 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.minimumPassword)
        } else if (request.confirmPassword?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.confirmPassword)
        }else if (request.confirmPassword!) != (request.newPassword!) {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.passwordMatch)
        }else{
            return true
        }
        return false
    }
}
