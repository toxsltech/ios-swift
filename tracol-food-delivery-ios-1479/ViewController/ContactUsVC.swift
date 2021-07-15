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

class ContactUsVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtViewDesciption: UITextView!
    
     //MARK:- Objects
    let objContactUsVM = ContactUsVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldName,txtFldEmail])
        txtFldEmail.text = objUserModel.email
        txtFldName.text = objUserModel.fullName
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionSubmit(_ sender: UIButton) {
        let objReq = ContactUsRequest.init(name: txtFldName.text!, email: txtFldEmail.text!, descriptions: txtViewDesciption.text!)
        objContactUsVM.contactUsApi(objReq) {
            RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)
        }
    }
}

