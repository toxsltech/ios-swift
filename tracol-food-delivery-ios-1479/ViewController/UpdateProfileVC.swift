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

class UpdateProfileVC: UIViewController,CustomGalleryProtocol {
    //MARK:- IBOtlets
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldMobileNumber: UITextField!
    @IBOutlet weak var imgViewProfile: UIImageView!
    
     //MARK:- Objects
    let objUpdateProfileVM = UpdateProfileVM()
    
    //MARK:- UIView Life CycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.connectAllTxtFieldFields(txtfields: [txtFldFirstName,txtFldLastName,txtFldEmail,txtFldMobileNumber])
        objUpdateProfileVM.objCustomGalleryClass.delegate = self
        handleProfileData()
    }
    func didGetSelectedImage(image: UIImage, path: String) {
        imgViewProfile.image = image
    }
    func handleProfileData() {
        txtFldFirstName.text = objUserModel.firstName
        txtFldLastName.text = objUserModel.lastName
        txtFldEmail.text = objUserModel.email
        txtFldMobileNumber.text = objUserModel.phoneNumber
        imgViewProfile.sd_setImage(with: URL(string:objUserModel.profilePic ), placeholderImage:#imageLiteral(resourceName: "ic_userdummy"))
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionCamera(_ sender: UIButton) {
        objUpdateProfileVM.objCustomGalleryClass.customActionSheet(controller: self)
    }
    @IBAction func actionSave(_ sender: UIButton) {
        view.endEditing(true)
        let objReq = UpDateProfileRequest(firstName: txtFldFirstName.text!, lastName: txtFldLastName.text! , email: txtFldEmail.text!, mobileNo: txtFldMobileNumber.text!,profilePic: imgViewProfile.image)
        objUpdateProfileVM.editProfileApi(objReq) {
            self.popToBack(false)
        }
    }
}
