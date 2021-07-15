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

class SearchListVC: UIViewController {
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var collViewSearchList: UICollectionView!
    //MARK:- Objects
    let objSearchListVM = SearchListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchApi()
    }
    func searchApi(){
        self.objSearchListVM.arrPackagesListModel = []
        collViewSearchList.backgroundView = nil
        objSearchListVM.userSeacrhApi {
            if self.objSearchListVM.arrPackagesListModel.count == 0 {
                self.noDataFound(self.collViewSearchList)
            }
            self.collViewSearchList.reloadData()
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        KAppDelegate.sideMenu.openLeft()
    }
}
