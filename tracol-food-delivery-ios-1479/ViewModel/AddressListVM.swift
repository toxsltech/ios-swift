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

class AddressListVM: NSObject {
    //MARK:- Variables
    var arrAddressListModel = [AddressListModel]()
    var selectedId = Int()
    var totalPrice = Int()
    var totalPage  = 0
    var currentPage  = 0
    var isEdited = false
    
    
    //MARK:- Get Videos List Api
    func getAddressListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getAddressList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if self.currentPage == 0 {
                        self.arrAddressListModel = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPage  = dictMeta["pageCount"] as! Int
                    }
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objAddressListModel = AddressListModel()
                                objAddressListModel.setDetail(detialDict: detialDict)
                                self.arrAddressListModel.append(objAddressListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    // MARK:- API Handling
    func placeOrderApi(_ request : PlaceOrderRequest, completion:@escaping(_ url: String) -> Void )  {
        let result = AccountService.placeOrder(request).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                debugPrint("result",response!)
                if let data = response!.data{
                    if let dataVal = data["Order"] as? NSDictionary{
                        let paymentUrl = dataVal["payment_url"] as? String ?? ""
                        completion(paymentUrl)
                        Proxy.shared.displayStatusCodeAlert(data["message"] as? String ?? "")
                    }
                }
            }
        }
    }
    
    func deleteAddressApi(_ id : Int,  completion:@escaping() -> Void )  {
        let result = AccountService.deleteAddress(id: id).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                debugPrint("result",response!)
                if let data = response!.data{
                    completion()
                    Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                }
            }
        }
    }
    func defaultAddressApi(_ id : Int,  completion:@escaping() -> Void )  {
        let result = GetFeaturesService.defaultAddress(id: id).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                debugPrint("result",response!)
                if let data = response!.data{
                    completion()
                    Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                }
            }
        }
    }
}
//MARK:- UITAbleView Delegates Methods
extension AddressListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return objAddressListVM.arrAddressListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressListTVC.className) as! AddressListTVC
        let dict = objAddressListVM.arrAddressListModel[indexPath.row]
        cell.lblAdreess.text = dict.address
        cell.lblContactNumber.text = "Phone Number: \(dict.contactNo)"
        cell.lblZipCode.text = "Zip Code: \(dict.zipcode)"
        if dict.isDefault == 1 {
            cell.btnTick.isSelected = true
            cell.btnDelete.isHidden = true
        }else{
            cell.btnTick.isSelected = false
            cell.btnDelete.isHidden = false
        }
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnTick.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(actionDeleteAdress), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(actionEditAdress), for: .touchUpInside)
        cell.btnTick.addTarget(self, action: #selector(actionSelect), for: .touchUpInside)
        
        return cell
    }
    @objc func actionDeleteAdress(_ sender: UIButton) {
        let dict = objAddressListVM.arrAddressListModel[sender.tag]
        DispatchQueue.main.async {
            self.deleteAlert(AlertMessage.deleteAddressAlert){_ in
                self.objAddressListVM.deleteAddressApi(dict.id){
                    self.objAddressListVM.arrAddressListModel.remove(at: sender.tag)
                    self.tblVwAddress.reloadData()
                    self.btnContinue.isHidden = self.title == "My Addresses" ? true : self.objAddressListVM.arrAddressListModel.isEmpty
                    if self.objAddressListVM.arrAddressListModel.isEmpty{
                        self.noDataFound(self.tblVwAddress,msg: "No address found")
                        self.tblVwAddress.reloadData()
                    }else{
                         self.tblVwAddress.backgroundView = nil
                        self.tblVwAddress.reloadData()
                    }
                }
            }
        }
    }
    @objc func actionEditAdress(_ sender: UIButton) {
        let dict = objAddressListVM.arrAddressListModel[sender.tag]
        let controller = mainStoryboard.instantiateViewController(withIdentifier: AddAddressVC.className) as! AddAddressVC
        controller.objAddAddressVM.objAddressListModel = dict
        controller.title = "Update Address"
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @objc func actionSelect(_ sender: UIButton) {
        
        if sender.isSelected {
            return
        }else {
            let dict = objAddressListVM.arrAddressListModel[sender.tag]
            objAddressListVM.defaultAddressApi(dict.id){
                self.objAddressListVM.getAddressListApi {
                    self.tblVwAddress.reloadData()
                    sender.isSelected = !sender.isSelected
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == objAddressListVM.arrAddressListModel.count-1 {
            if objAddressListVM.totalPage > objAddressListVM.currentPage+1 {
                objAddressListVM.currentPage += 1
                objAddressListVM.getAddressListApi() {
                    DispatchQueue.main.async {
                        self.tblVwAddress.reloadData()
                    }
                }
            }
        }
    }
}
