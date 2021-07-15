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
import CoreData

class OrderDetailVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var vwMerchantDetails: UIView!
    @IBOutlet weak var tblVwCartItems: UITableView!
    
    //MARK:- Objects
    let objOrderDetailVM = OrderDetailVM()
    var context:NSManagedObjectContext!
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objOrderDetailVM.orderDetailApi("\(title!)"){
            self.tblVwCartItems.reloadData()
        }
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
}
