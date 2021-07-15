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

class SplashVC: UIViewController {
    
     //MARK:- Objects
    let objSplashVM = SplashVM()
    
    //MARK:- UIView Life Cycle Mthods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if Proxy.shared.accessNil() != ""{
            self.objSplashVM.checkUserApi {
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                    RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)
                }
            }
        } else {
            self.moveToNext(LoginVC.className,animation: false)
        }
    }
}
