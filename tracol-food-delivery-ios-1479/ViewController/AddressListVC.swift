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

class AddressListVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblVwAddress : UITableView!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    //MARK:- Objects
    let objAddressListVM = AddressListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        btnImage.setImage(title == "My Addresses" ?  #imageLiteral(resourceName: "ic_drawer")  :#imageLiteral(resourceName: "ic_backblack") , for: .normal)
        objAddressListVM.currentPage = 0
        objAddressListVM.getAddressListApi {
            self.btnContinue.isHidden = self.title == "My Addresses" ? true : self.objAddressListVM.arrAddressListModel.isEmpty
            self.tblVwAddress.reloadData()
            if self.objAddressListVM.arrAddressListModel.isEmpty{
                self.noDataFound(self.tblVwAddress,msg: "No address found")
                self.tblVwAddress.reloadData()
            }else{
                self.tblVwAddress.backgroundView = nil
                self.tblVwAddress.reloadData()
            }
        }
    }
    //MARK:- UIActions
    @IBAction func actioBack(_ sender: UIButton) {
        if title == "My Addresses" {
            KAppDelegate.sideMenu.openLeft()
        } else{
            popToBack()
        }
    }
    @IBAction func actionAddAddress(_ sender: UIButton) {
        //if objUserModel.subscriptionId != 0 {
            moveToNext(AddAddressVC.className)
        //}else{
            //  Proxy.shared.displayStatusCodeAlert(AlertMessage.updateProfile)
        //}
    }
    @IBAction func actionContinue(_ sender: UIButton) {
        if objAddressListVM.arrAddressListModel.count == 0 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.addAddress)
        }else{
            var defaultAddressId = Int()
            for dict in objAddressListVM.arrAddressListModel {
                if dict.isDefault == 1{
                    defaultAddressId = dict.id
                    break
                }
            }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do  {
                try KAppDelegate.persistentContainer.viewContext.execute(deleteRequest)
                try KAppDelegate.persistentContainer.viewContext.save()
            }
            catch
            {
                debugPrint("There was an error")
            }
            let objPlaceOrderRequest = PlaceOrderRequest(itemArr: self.title!, addressId: defaultAddressId, totalAmount: objAddressListVM.totalPrice)
            
            objAddressListVM.placeOrderApi(objPlaceOrderRequest) { (paymentUrl) in
                self.moveToNext(PaymentWebViewVC.className,titleStr: paymentUrl)
            }
        }
    }
}
