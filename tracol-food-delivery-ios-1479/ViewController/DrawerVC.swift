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

class DrawerVC: UIViewController {
    //MARK:- IBOtlets
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    
     //MARK:- Objects
    let objDrawerVM = DrawerVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        profileDataHandling()
        
    }
    //MARK:- DataHAndling
    func profileDataHandling()  {
        lblFullName.text! = objUserModel.fullName
        imgViewProfile.sd_setImage(with: URL(string:objUserModel.profilePic ), placeholderImage:#imageLiteral(resourceName: "ic_userdummy"))
    }
    //MARK:- UIActions
    @IBAction func actionLogout(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.deleteAlert(AlertMessage.logoutAlert){_ in
                self.objDrawerVM.logoutUserApi {
                   // UIApplication.shared.statusBarStyle = .default
                    RootControllerProxy.shared.rootWithoutDrawer(LoginVC.className)
                }
                
            }
        }
    }
}
