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

class ForgotPasswordVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldEmail: UITextField!
    
     //MARK:- Objects
    let objForgotPasswordVM = ForgotPasswordVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldEmail])
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    //MARK:- UIActions
    @IBAction func actionSend(_ sender: UIButton) {
        let objReq = ForgotPasswordRequest(email: txtFldEmail.text!)
        objForgotPasswordVM.forgotPasswordApi(objReq) {
            self.popToBack()
        }
    }
}
