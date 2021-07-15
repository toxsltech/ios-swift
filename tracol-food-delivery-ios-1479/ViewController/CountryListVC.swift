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

class CountryListVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tblVwCountryList: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldSearch: UITextField!
    
     //MARK:- Objects
    let objCountryListVM = CountryListVM()
    var complition : completionHandler?
    typealias completionHandler = (String,Int) -> Void
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == "Country" {
            lblTitle.text = "Select Country"
            objCountryListVM.countryListArr = []
            objCountryListVM.getCountryListApi {
                self.tblVwCountryList.reloadData()
            }
        } else {
            lblTitle.text = "Select City"
            objCountryListVM.cityListArr = []
            objCountryListVM.getCityListApi(objCountryListVM.selectedId) {
                self.tblVwCountryList.reloadData()
            }
        }
    }
    //MARK:-IBActions
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true)
    }
}
