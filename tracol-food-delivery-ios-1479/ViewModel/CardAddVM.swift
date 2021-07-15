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

class CardAddVM: NSObject {
    // MARK:- API Handling
    func addcardApi(_ request : AddCardRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.addCard(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    if let data = response!.data{
                        Proxy.shared.displayStatusCodeAlert(data["message"] as? String ?? "")
                        completion()
                    }
                }
            }
        }
    }
    
    // MARK:- Validation Handling
    func validData(_ request: AddCardRequest) -> Bool {
        if (request.cardholderName?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.name)
        }else if (request.cardNubmer?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.cardNumber)
        }else if request.cardNubmer!.count < 16 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validCardNumber)
        }else if (request.expiryDate?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.cardMonth)
        }else if (request.cvv?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.cardCvv)
        }else if request.cvv!.count < 3 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validCVV)
            
        }else{
            return true
        }
        return false
    }
}
extension CardAddVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldCardNumber {
            if range.location >= 16 {
                return false
            }
        }else  if textField == txtFldCVV{
            if range.location >= 3{
                return false
            }
            
        }
        return true
    }
}
