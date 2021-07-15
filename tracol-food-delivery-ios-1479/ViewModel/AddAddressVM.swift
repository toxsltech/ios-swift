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

class AddAddressVM: NSObject {
    
    var objAddressListModel = AddressListModel()
    
    // MARK:- API Handling
    func addAddressApi(_ request : AddAddressRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.addAddress(request).task
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
    // MARK:- API Handling
    func updateAddressApi(_ request : UpdateAddressRequest,idAddress:String, completion:@escaping() -> Void )  {
        if validData(request){
            let result = AccountService.updateAddress(request: request, id: idAddress).task
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
    func validData(_ request: AddAddressRequest) -> Bool {
        if (request.address?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.address)
        }else if (request.city?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.city)
        }else if (request.zipCode?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.zipCode)
        }else if request.zipCode!.count < 5 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.zipCodeCount)
        }else if (request.contactNo?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.mobileNumber)
        }else if request.contactNo!.count < 5 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.correctMobile)
        }else if (request.landMark?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.secondaryAddress)
        }else{
            return true
        }
        return false
    }
    // MARK:- Validation Handling
    func validData(_ request: UpdateAddressRequest) -> Bool {
        if (request.address?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.address)
        }else if (request.city?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.city)
        }else if (request.zipCode?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.zipCode)
        }else if request.zipCode!.count < 5 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.zipCodeCount)
        }else if (request.contactNo?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.mobileNumber)
        }else if request.contactNo!.count < 5 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.correctMobile)
        }else if (request.landMark?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.secondaryAddress)
        }else{
            return true
        }
        return false
    }
}
//MARK:- UITexFiled Delegates Methods
extension AddAddressVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPhoneNumber {
            guard let text = txtFldPhoneNumber.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 16
        }else if textField == txtFldZipCode  {
            guard let text = txtFldZipCode.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 6
        }
        return true
    }
    
}
