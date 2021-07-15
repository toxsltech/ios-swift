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

class PaymentDetailVC: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var tblVwCartItems: UITableView!
    
    //MARK:- Objects
    let objPaymentDetailVM = PaymentDetailVM()
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabse()
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionPay(_ sender: UIButton) {
        let arrCart = NSMutableArray()
        for i in 0..<objPaymentDetailVM.objAddCartVM.arrCartList.count {
            let data = objPaymentDetailVM.objAddCartVM.arrCartList[i]
            let price = data.value(forKey: "price") as? String ?? "0"
            let quantity = data.value(forKey: "quantity") as? Int ?? 0
            let id = data.value(forKey: "id") as? Int ?? 0
            let typeId = data.value(forKey: "typeId") as? Int ?? 0
            
            let dict = NSMutableDictionary()
            dict.setValue(id, forKey: "item_id")
            dict.setValue(price, forKey: "amount")
            dict.setValue(quantity, forKey: "quantity")
            dict.setValue(typeId, forKey: "type_id")
            arrCart.add(dict)
            
        }
        let objAddressListVC = self.storyboard?.instantiateViewController(withIdentifier: AddressListVC.className) as! AddressListVC
        objAddressListVC.title = Proxy.shared.serializationString(arr: arrCart)
        objAddressListVC.objAddressListVM.totalPrice  = Int(objPaymentDetailVM.totalPrice)
            self.navigationController?.pushViewController(objAddressListVC, animated: true)
        //moveToNext(AddressListVC.className,titleStr: Proxy.shared.serializationString(arr: arrCart))
    }
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse() {
        context = KAppDelegate.persistentContainer.viewContext
        fetchData()
    }
    func fetchData()  {
        objPaymentDetailVM.objAddCartVM.totalCartPrice = 0.0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            objPaymentDetailVM.objAddCartVM.arrCartList = result as! [NSManagedObject]
            DispatchQueue.main.async {
                self.tblVwCartItems.reloadData()
            }
        } catch {
            Proxy.shared.displayStatusCodeAlert("Fetching data Failed")
        }
    }
}
