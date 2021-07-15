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
import PTCardTabBar

class WishListVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collViewWishList: UICollectionView!
    @IBOutlet weak var viewProducts: UIView!
    @IBOutlet weak var viewPackages: UIView!
    @IBOutlet  var arrButton: [UIButton]!
    //MARK:- Objects
    let objWishListVM = WishListVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        actionBookingStatus(arrButton[self.objWishListVM.selectedtab == 2 ? 0 : 1])
    }
    
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
    @IBAction func actionBookingStatus(_ sender: UIButton) {
        if sender.tag == 2 {
            self.objWishListVM.productsFavouriteListApi {
                self.viewPackages.isHidden = false
                self.viewProducts.isHidden = true
                self.collViewWishList.reloadData()
            }
        }else{
            objWishListVM.packagesFavouriteListApi {
                self.viewPackages.isHidden = true
                self.viewProducts.isHidden = false
                self.collViewWishList.reloadData()
            }
        }
        self.objWishListVM.selectedtab = sender.tag
    }
}
