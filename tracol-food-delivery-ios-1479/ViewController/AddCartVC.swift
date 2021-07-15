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
import Lottie
import PTCardTabBar
class AddCartVC: UIViewController {
    //MARK:- IBoutlets
    @IBOutlet weak var tblVwCartItems: UITableView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblCartEmpty: UILabel!
    
    
    //MARK:- Objects
    let objAddCartVM = AddCartVM()
    var context:NSManagedObjectContext!
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        animationView.play()
        openDatabse()
    }
    
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionCheckout(_ sender: UIButton) {
        if objAddCartVM.arrCartList.count == 0 {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.addCart)
        }else{
            let objCheckOutVC = mainStoryboard.instantiateViewController(withIdentifier: CheckOutVC.className) as! CheckOutVC
            objCheckOutVC.objCheckOutVM.arrCartList = objAddCartVM.arrCartList
            self.navigationController?.pushViewController(objCheckOutVC, animated: true)
        }
    }
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse() {
        context = KAppDelegate.persistentContainer.viewContext
        fetchData()
    }
    func fetchData()  {
        objAddCartVM.totalCartPrice = 0.0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            objAddCartVM.arrCartList = result as! [NSManagedObject]
            DispatchQueue.main.async {
                if self.objAddCartVM.arrCartList.count == 0{
                    self.tblVwCartItems.isHidden = true
                    self.animationView.isHidden = false
                    self.lblCartEmpty.isHidden = false
                }else{
                    self.tblVwCartItems.isHidden = false
                    self.animationView.isHidden = true
                    self.lblCartEmpty.isHidden = true
                    self.tblVwCartItems.reloadData()
                }
            }
        } catch {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.fetchingFailed)
        }
    }
}
