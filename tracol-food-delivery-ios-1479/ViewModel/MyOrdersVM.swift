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

class MyOrdersVM: NSObject {
    //MARK:- Variables
    var arrOrderListModel = [OrderListModel]()
    var arrCartList = [NSManagedObject]()
    let objAddCartVM = AddCartVM()
    let objCheckOutVM = CheckOutVM()
    let objPaymentDetailVM = PaymentDetailVM()
    var totalPage  = 0
    var currentPage  = 0
    
    //MARK:- Api Handling
    func getOrderListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.orderList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if self.currentPage == 0 {
                        self.arrOrderListModel = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPage  = dictMeta["pageCount"] as! Int
                    }
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objOrderListModel = OrderListModel()
                                objOrderListModel.setDetail(detialDict: detialDict)
                                self.arrOrderListModel.append(objOrderListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
}
//MARK:- UITableView Delegate Methods
extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMyOrdersVM.arrOrderListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrdersTVC.className) as! MyOrdersTVC
        let dict = objMyOrdersVM.arrOrderListModel[indexPath.row]
        if dict.arrItemModel.count != 0{
            cell.lblTitle.text = dict.arrItemModel[0].title
            cell.lblOrderId.text = " Order Id: \(dict.arrItemModel[0].orderId)"
            cell.lblShowDate.text = dict.date
            if dict.orderStatus == 0 {
                cell.lblOrderStatus.text! = orderStatusUnpaid
                cell.lblOrderStatus.textColor = .red
            }else{
                cell.lblOrderStatus.text! = orderStatusPaid
                cell.lblOrderStatus.textColor = .blue
            }
            cell.imgViewOrder.sd_setImage(with: URL(string:dict.arrItemModel[0].itemImg), placeholderImage:#imageLiteral(resourceName: "ic_fruit"))
        }else{
            cell.lblTitle.text = "No item"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objOrderDetailVC = mainStoryboard.instantiateViewController(withIdentifier: OrderDetailVC.className) as! OrderDetailVC
        let dict = objMyOrdersVM.arrOrderListModel[indexPath.row]
        objOrderDetailVC.title = "\(dict.id)"
        //objOrderDetailVC.objOrderDetailVM.orderDict = dict
        self.navigationController?.pushViewController(objOrderDetailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == objMyOrdersVM.arrOrderListModel.count-1 {
            if objMyOrdersVM.totalPage > objMyOrdersVM.currentPage+1 {
                objMyOrdersVM.currentPage += 1
                objMyOrdersVM.getOrderListApi() {
                    DispatchQueue.main.async {
                        self.tblViewOrderList.reloadData()
                    }
                }
            }
        }
    }
}
