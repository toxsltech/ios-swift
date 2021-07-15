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

class MyOrdersVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tblViewOrderList: UITableView!
    
    //MARK:- Objects
    let objMyOrdersVM = MyOrdersVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objMyOrdersVM.getOrderListApi{
            if self.objMyOrdersVM.arrOrderListModel.count == 0 {
                self.noDataFound(self.tblViewOrderList)
                self.tblViewOrderList.reloadData()
            }else{
                self.tblViewOrderList.reloadData()
            }
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
}
