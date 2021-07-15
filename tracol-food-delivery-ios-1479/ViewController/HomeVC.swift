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

class HomeVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tblViewHome: UITableView!
        
    //MARK:- Objects
    let objHomeVM = HomeVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objHomeVM.getPackagesListApi {
            self.tblViewHome.reloadData()
        }
//        objHomeVM.getBannerListApi {
//            self.tblViewHome.reloadData()
//        }
        objHomeVM.getVideosListApi {
            self.tblViewHome.reloadData()
        }
//        objHomeVM.hitUserSubscriptionPlanApi(objUserModel.subscriptionId){
//        self.tblViewHome.reloadData()
//    }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionSearch(_ sender: UIButton) {
        moveToNext(SearchListVC.className, animation: false)
    }
    
}
