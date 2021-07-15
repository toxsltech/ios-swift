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

class MyProfileVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblRegisteredBy: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    
    //MARK:- Objects
    let objSplashVM = SplashVM()
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.objSplashVM.checkUserApi {
                self.profileDataHandling()
        }
    }
    // MARK:- DataHAndling
    func profileDataHandling()  {
        lblFullName.text! = objUserModel.fullName
        lblEmail.text = objUserModel.email
        lblPhoneNumber.text = objUserModel.phoneNumber
        imgViewProfile.sd_setImage(with: URL(string:objUserModel.profilePic ), placeholderImage:#imageLiteral(resourceName: "ic_userdummy"))
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionEdit(_ sender: UIButton) {
        moveToNext(UpdateProfileVC.className)
    }
}
