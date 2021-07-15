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

class DonationVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldAmount: UITextField!
    @IBOutlet weak var btnTick: UIButton!
    
    var complition : completionHandler?
    typealias completionHandler = (String) -> Void
    var charityId = Int()
    
    //MARK:- Objects
    var objDonationVM = DonationVM ()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldAmount])
    }
    //MARK:- UIActions
    @IBAction func actionCross(_ sender: UIButton) {
        dismissController()
    }
    //MARK:- UIActions
    @IBAction func actionCheck(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    //MARK:- UIActions
    @IBAction func actionTerms(_ sender: UIButton) {
        guard let finalComp = self.complition else {
                           return
                       }
        self.dismiss(animated: true, completion: nil)
        finalComp("TermCondition")
    }
    
    @IBAction func actionDonate(_ sender: UIButton) {
        if btnTick.isSelected == true {
            let objReq = PayDonationRequest(amount: txtFldAmount.text!, charityId: charityId)
            objDonationVM.payDonationApi(objReq) { (paymentUrl) in
                guard let finalComp = self.complition else {
                    return
                }
                self.dismiss(animated: true, completion: nil)
                finalComp(self.objDonationVM.paymentUrl)
            }
        }else{
            Proxy.shared.displayStatusCodeAlert(AlertMessage.acceptTermsCondition)
        }
    }
}
