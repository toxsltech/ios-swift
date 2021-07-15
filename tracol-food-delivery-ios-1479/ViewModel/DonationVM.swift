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

class DonationVM: NSObject {
    //MARK:- Variables
    var paymentUrl = String()
    
    // MARK:- API Handling
    func payDonationApi(_ request : PayDonationRequest, completion:@escaping(_ url: String) -> Void )  {
        if validData(request){
            let result = AccountService.payDonation(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    if let data = response!.data{
                        if let dataVal = data["detail"] as? NSDictionary{
                            self.paymentUrl = dataVal["payment_url"] as? String ?? ""
                            completion(self.paymentUrl)
                            Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                        }
                    }
                }
            }
        }
    }
    // MARK:- Validation Handling
    func validData(_ request: PayDonationRequest) -> Bool {
        if (request.amount?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.amount)
        }else{
            return true
        }
        return false
    }
}
//MARK:- UITexFiled Delegates Methods
extension DonationVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = txtFldAmount.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 6
    }
}
