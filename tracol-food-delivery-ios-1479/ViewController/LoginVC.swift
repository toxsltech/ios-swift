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

class LoginVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnRememberMe: UIButton!
    
     //MARK:- Objects
    let objLoginVM = LoginVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldEmail,txtFldPassword])
        txtFldEmail.text = Proxy.shared.getRememberVal().0
        txtFldPassword.text = Proxy.shared.getRememberVal().1
        if txtFldEmail.text != ""{
            btnRememberMe.isSelected = true
        }
    }
    //MARK:- Custom methods
    func setValueRemeber() {
        if btnRememberMe.isSelected{
            UserDefaults.standard.set(txtFldEmail.text!, forKey: "email")
            UserDefaults.standard.set(txtFldPassword.text!, forKey: "password")
        } else {
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "password")
        }
        UserDefaults.standard.synchronize()
    }
    //MARK:- UIActions
    @IBAction func actionEye(_ sender: UIButton) {
        txtFldPassword.isSecureTextEntry = !txtFldPassword.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    @IBAction func actionRememberMe(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func actionForgotPassword(_ sender: UIButton) {
        moveToNext(ForgotPasswordVC.className)
    }
    @IBAction func actionLogIn(_ sender: UIButton) {
        view.endEditing(true)
        let objReq = LoginRequest(email: txtFldEmail.text!, password: txtFldPassword.text!)
        objLoginVM.loginApi(objReq) {
            self.setValueRemeber()
            if self.btnRememberMe.isSelected{
                UserDefaults.standard.setValue(self.txtFldEmail.text, forKey: AlertMessage.email)
                UserDefaults.standard.setValue(self.txtFldPassword.text, forKey: AlertMessage.password)
                UserDefaults.standard.synchronize()
            }
            RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)
        }
    }
}
