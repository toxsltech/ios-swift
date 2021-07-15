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

class AddAddressVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldZipCode: UITextField!
    @IBOutlet weak var txtFldPhoneNumber: UITextField!
    @IBOutlet weak var txtFldLandmark: UITextField!
    
    //MARK:- Objects
    let objAddAddressVM = AddAddressVM()
    
    //MARK:- UILifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldAddress,txtFldCity,txtFldZipCode,txtFldPhoneNumber,txtFldLandmark])
        if self.title != "" {
            updateData()
        }
    }
    func updateData(){
        let dict = objAddAddressVM.objAddressListModel
        txtFldAddress.text = dict.address
        txtFldCity.text = dict.city
        txtFldZipCode.text = dict.zipcode
        txtFldPhoneNumber.text = dict.contactNo
        txtFldLandmark.text = dict.secondaryAddress
    }
    
    //MARK:- UIActions
    @IBAction func actioBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionAddDress(_ sender: UIButton) {
        view.endEditing(true)
        if self.title != "" {
            let request = UpdateAddressRequest(address: txtFldAddress.text!, city: txtFldCity.text!, zipCode: txtFldZipCode.text!, contactNo: txtFldPhoneNumber.text!, landMark: txtFldLandmark.text!)
            objAddAddressVM.updateAddressApi(request, idAddress: "\(objAddAddressVM.objAddressListModel.id)") {
                self.popToBack(false)
            }
        }else{
            let request = AddAddressRequest(address: txtFldAddress.text!, city: txtFldCity.text!, zipCode: txtFldZipCode.text!, contactNo: txtFldPhoneNumber.text!, landMark: txtFldLandmark.text!)
            objAddAddressVM.addAddressApi(request) {
                self.popToBack(false)
            }
        }
    }
}

