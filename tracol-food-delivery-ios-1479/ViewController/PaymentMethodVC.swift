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

class PaymentMethodVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tblVwCardList: UITableView!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnContinue: UIButton!

            //MARK:- Objects
    var objPaymentMethodVM = PaymentMethodVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "Payment" {
            btnImage.setImage(#imageLiteral(resourceName: "ic_drawer"), for: .normal)
            lblHeader.text = "Payment Method"
            btnContinue.isHidden = true
            
        } else{
            btnImage.setImage(#imageLiteral(resourceName: "ic_backblack"), for: .normal)
            lblHeader.text = "Payment"
            btnContinue.isHidden = false

            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //  objPaymentMethodVM.getCardListApi {
        //     self.tblVwCardList.reloadData()
        // }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        if title == "Payment" {
            KAppDelegate.sideMenu.openLeft()
        } else{
            popToBack()
            
        }
    }
    @IBAction func actionContinue(_ sender: UIButton) {
        moveToNext(CheckOutVC.className)
      }
    @IBAction func actionAddCard(_ sender: UIButton) {
        moveToNext(CardAddVC.className)
    }
}
