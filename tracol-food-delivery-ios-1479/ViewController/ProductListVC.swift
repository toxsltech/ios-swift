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
import PTCardTabBar


class ProductListVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collViewFruitList: UICollectionView!
    @IBOutlet weak var btnCart: SYBadgeButton!
    @IBOutlet weak var vwScroll: UIScrollView!

    //MARK:- Objects
    let objProductListVM = ProductListVM()
    var context:NSManagedObjectContext!

    //MARK:- UIView Life Cycle Mthods
    override func viewDidLoad() {
        super.viewDidLoad()
        objProductListVM.getFruitListApi {
            self.collViewFruitList.reloadData()
        }
       getCartCountFromCoreData()
        
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionCart(_ sender: UIButton) {
     //   self.tabBarController?.selectedIndex = 2
                    //  objPassIndexDelegate?.passIndex(index: self.tabBarController?.selectedIndex ?? 0)
        //self.tabBarController?.selectedIndex = 2
       RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className,titleStr: "cart")
    }
    //MARK:- Core data methods
    func fetchData()  {
        context = KAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)
        } catch {
            Proxy.shared.displayStatusCodeAlert("Fetching data Failed")
        }
    }
    func openDatabse() {
        context = KAppDelegate.persistentContainer.viewContext
    }
    
    func getCartCountFromCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        
        do {
            let results = try KAppDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            btnCart.badgeValue =  "\(results.count)"
            
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
