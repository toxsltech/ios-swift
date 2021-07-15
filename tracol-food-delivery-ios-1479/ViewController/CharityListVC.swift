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

class CharityListVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var tblVwCharityList : UITableView!
    @IBOutlet weak var btnImage: UIButton!
    
    
    //MARK:- Objects
    let objCharityListVM = CharityListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "Charity" {
            btnImage.setImage(#imageLiteral(resourceName: "ic_drawer"), for: .normal)
            
        } else{
            btnImage.setImage(#imageLiteral(resourceName: "ic_backblack"), for: .normal)
        }
        objCharityListVM.getCharityListApi{
            self.tblVwCharityList.reloadData()
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        if title == "Charity" {
            KAppDelegate.sideMenu.openLeft()
            
        } else{
            popToBack()
        }
}
}
