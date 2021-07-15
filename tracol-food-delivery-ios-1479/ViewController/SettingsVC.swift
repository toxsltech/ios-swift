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

class SettingsVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var btnNotificationOnOff: UIButton!
    
    //MARK:- Objects
    let objSettingsVM = SettingsVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if objUserModel.notificationStatus == 1 {
            self.btnNotificationOnOff.setImage (#imageLiteral(resourceName: "ic_on"), for: .normal)
        }else {
            self.btnNotificationOnOff.setImage(#imageLiteral(resourceName: "ic_off"), for: .normal)
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionNotification(_ sender: UIButton) {
        var notificationValue = Int()
        if objUserModel.notificationStatus == 0 {
           notificationValue = 1
        }
        objSettingsVM.enableNotificationApi(notificationValue) {
            if objUserModel.notificationStatus == 0 {
                self.btnNotificationOnOff.setImage(#imageLiteral(resourceName: "ic_off"), for: .normal)
            }else{
                self.btnNotificationOnOff.setImage(#imageLiteral(resourceName: "ic_on"), for: .normal)
            }
        }
    }
    @IBAction func actionChangePassword(_ sender: UIButton) {
        moveToNext(ChangePasswordVC.className)
    }
}
