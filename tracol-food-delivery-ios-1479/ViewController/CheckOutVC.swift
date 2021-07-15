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

class CheckOutVC: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var tblVwCartItems: UITableView!
    
    //MARK:- Objects
    let objCheckOutVM = CheckOutVM()
    var context:NSManagedObjectContext!
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabse()
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionTerm(_ sender: UIButton) {
        moveToNext(AboutUsVC.className, titleStr: "Terms")
    }
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse() {
        context = KAppDelegate.persistentContainer.viewContext
        fetchData()
    }
    func fetchData()  {
        objCheckOutVM.objAddCartVM.totalCartPrice = 0.0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            objCheckOutVM.objAddCartVM.arrCartList = result as! [NSManagedObject]
            DispatchQueue.main.async {
                self.tblVwCartItems.reloadData()
            }
        } catch {
            Proxy.shared.displayStatusCodeAlert("Fetching data Failed")
        }
    }
}
