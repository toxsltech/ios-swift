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

class CardAddVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldCardNumber: UITextField!
    @IBOutlet weak var txtFldExpiryDate: UITextField!
    @IBOutlet weak var txtFldCVV: UITextField!
    
    //MARK:- Objects
    let objCardAddVM = CardAddVM()
    //MARK:- UIview Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionSave(_ sender: UIButton) {
        let request = AddCardRequest.init(cardholderName: txtFldName.text!, cardNubmer: txtFldCardNumber.text!, expiryDate: txtFldExpiryDate.text, cvv: txtFldCVV.text, isDefault: "0")
        objCardAddVM.addcardApi(request) {
            self.popToBack(false)
        }
    }
}
