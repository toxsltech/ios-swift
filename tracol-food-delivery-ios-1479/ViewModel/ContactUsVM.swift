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

class ContactUsVM: NSObject {
    //MARK:- Api Handling
    func contactUsApi(_ request : ContactUsRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.contactUs(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    if let data = response!.data{
                        completion()
                        Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                    }
                }
            }
        }
    }
    // MARK:- Validation Handling
    func validData(_ request: ContactUsRequest) -> Bool {
        if (request.name?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.name)
        }else if !Proxy.shared.isValidName(request.name!){
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validName)
        }else if (request.email?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.email)
        }else if !Proxy.shared.isValidEmail(request.email!){
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validEmail)
        }else if (request.descriptions?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.comment)
        }else{
            return true
        }
        return false
    }
}
