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

class LoginVM: NSObject {
    // MARK:- API Handling
    func loginApi(_ request : LoginRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.login(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    if let data = response!.data{
                        UserDefaults.standard.set(data["access-token"] as? String ?? "", forKey: "access-token")
                        UserDefaults.standard.synchronize()
                        if let dataVal = data["User-Detail"] as? NSDictionary{
                            objUserModel.setDetail(dataVal)
                            completion()
                            Proxy.shared.displayStatusCodeAlert(AlertMessage.loginSuccess)
                        }else{
                            Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                        }
                    }
                }
            }
        }
    }
    
    // MARK:- Validation Handling
    func validData(_ request: LoginRequest) -> Bool {
        if (request.email?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.email)
        }else if !Proxy.shared.isValidEmail(request.email!){
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validEmail)
        }
        else if (request.password?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.password)
        }else{
            return true
        }
        return false
    }
}
