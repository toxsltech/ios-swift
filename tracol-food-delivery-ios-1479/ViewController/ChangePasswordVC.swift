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

class ChangePasswordVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldNewPassword: UITextField!
    @IBOutlet weak var txtFldConfirmPassword: UITextField!
    
     //MARK:- Objects
    let objChangePasswordVM = ChangePasswordVM()
    
    //MARK:- UIViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldNewPassword,txtFldConfirmPassword])
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.tag {
        case 0:
            txtFldNewPassword.isSecureTextEntry = !txtFldNewPassword.isSecureTextEntry
        case 1:
            txtFldConfirmPassword.isSecureTextEntry = !txtFldConfirmPassword.isSecureTextEntry
        default:
            break
        }
    }
    @IBAction func actionSubmit(_ sender: UIButton) {
        view.endEditing(true)
        let objReq = ChangePasswordRequest(newPassword: txtFldNewPassword.text!, confirmPassword: txtFldConfirmPassword.text!)
        objChangePasswordVM.changePasswordApi(objReq){
            self.moveToNext(LoginVC.className)
        }
    }
}
