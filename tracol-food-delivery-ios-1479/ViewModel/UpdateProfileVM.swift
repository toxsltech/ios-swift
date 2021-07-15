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

class UpdateProfileVM: NSObject {
    //MARK:- Variables
    var objCustomGalleryClass = CustomGalleryClass()
    var countryId = Int()
    //MARK:- Api Handling
    func editProfileApi(_ request : UpDateProfileRequest, completion:@escaping() -> Void )  {
        if validData(request){
            let result = ImagesService.updateProfile(request).task
            result.responseJSON { (resData) in
                WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                    debugPrint("result",response!)
                    if let data = response!.data{
                        if let dataVal = data["detail"] as? NSDictionary{
                            objUserModel.setDetail(dataVal)
                            completion()
                            Proxy.shared.displayStatusCodeAlert(AlertMessage.profileUpdatedSuccess)
                        }
                    }
                }
            }
        }
    }
    // MARK:- Validation Handling
    func validData(_ request: UpDateProfileRequest) -> Bool {
        if (request.firstName?.isBlank)!{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.firstName)
            }else if !Proxy.shared.isValidName(request.firstName!){
            Proxy.shared.displayStatusCodeAlert(AlertMessage.validName)
//        }else if (request.lastName?.isBlank)!{
//            Proxy.shared.displayStatusCodeAlert(AlertMessage.lastName)
//        }else if (request.email?.isBlank)! {
            //Proxy.shared.displayStatusCodeAlert(AlertMessage.email)
        }else if (request.mobileNo?.isBlank)! {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.mobileNumber)
        }else if request.mobileNo!.count < 5 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.correctMobile)
        }else{
            return true
        }
        return false
    }
}
//MARK:- UITexFiled Delegates Methods
extension UpdateProfileVC : UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == txtFldCountry {
//            let controller  = self.storyboard?.instantiateViewController(withIdentifier: "CountryListVC") as! CountryListVC
//            controller.complition = {
//                title,id in
//                
//                self.txtFldCountry.text! = title
//                self.objUpdateProfileVM.countryId = id
//            }
//            controller.title = "Country"
//            self.navigationController?.present(controller, animated: true)
//            txtFldCity.text = ""
//            return false
//        } else if textField == txtFldCity {
//            let controller  = self.storyboard?.instantiateViewController(withIdentifier: "CountryListVC") as! CountryListVC
//            controller.complition = {
//                title,id in
//                self.txtFldCity.text! = title
//                self.objUpdateProfileVM.countryId = id
//                
//            }
//            controller.title = "City"
//            controller.objCountryListVM.selectedId = self.objUpdateProfileVM.countryId
//            self.navigationController?.present(controller, animated: true)
//            return false
//        }
//        return true
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = txtFldMobileNumber.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 16
    }
}
