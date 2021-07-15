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

class NotificationsVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tblViewNotificationList: UITableView!
    
    //MARK:- Objects
    let objNotificationsVM = NotificationsVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objNotificationsVM.getNotificationListApi {
            if self.objNotificationsVM.NotficationListModelArr.count == 0 {
                self.noDataFound(self.tblViewNotificationList)
                self.tblViewNotificationList.reloadData()
            }else{
                self.tblViewNotificationList.reloadData()
            }
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
}
