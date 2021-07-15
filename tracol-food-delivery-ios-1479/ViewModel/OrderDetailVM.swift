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

class OrderDetailVM: NSObject {
    //MARK:- Variables
    var arrCartList = [NSManagedObject]()
    var totalCartPrice = Double()
    let objAddCartVM = AddCartVM()
    var isEdited = false
    var orderDict = OrderListModel()
    var orderId = Int()
    var objOrderDetailModel = OrderDetailModel()



    //MARK:- Get Videos List Api
    func orderDetailApi(_ id: String, completion:@escaping() -> Void )  {
        let result = GetFeaturesService.orderDetail(id: id).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let detialDict = data["Detail"] as? NSDictionary{
                        self.objOrderDetailModel.setDetail(detialDict: detialDict)
                        completion()
                    }
                }
                
            }
        }
    }
}
//MARK:- UITableView Delegate Methods
extension OrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return objOrderDetailVM.objOrderDetailModel.arrItemModel.count != 0 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? objOrderDetailVM.objOrderDetailModel.arrItemModel.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCartTVC.className) as! AddCartTVC
            let data = objOrderDetailVM.objOrderDetailModel.arrItemModel[indexPath.row]
            let price = data.amount
            let quantity = data.quantity
            cell.lblProductName.text = data.title
            cell.lblQuantity.text = "\(price) X \(quantity)"
            return cell
        } else {
            let footerCell = tableView.dequeueReusableCell(withIdentifier: CheckOutFooterTVC.className) as! CheckOutFooterTVC
            footerCell.lblItemsQuantity.text = "Items: \(objOrderDetailVM.objOrderDetailModel.arrItemModel.count)"
            footerCell.lblItemsQuantityPrice.text = "\(currency) \(updateTotalPrice().0)"
            footerCell.lblItemPrice.text = "\(currency) \(updateTotalPrice().0)"
            footerCell.lblDeliveryCharges.text = "\(currency) \(objUserModel.deliveryCharges) * \(updateTotalPrice().1)"
            let finalDelivery = objUserModel.deliveryCharges*updateTotalPrice().1
            footerCell.lblTotal.text = "\(currency) \(updateTotalPrice().0+finalDelivery)"
            footerCell.btnRepayment.tag = indexPath.row
            footerCell.btnRepayment.addTarget(self, action: #selector(actionRepayment), for: .touchUpInside)
            if objOrderDetailVM.objOrderDetailModel.orderStatus == 0{
                footerCell.lblPaymentStatus.text = orderStatusUnpaid
                footerCell.btnRepayment.isHidden = false
                footerCell.btnRepayment.backgroundColor = .systemRed
            } else{
                footerCell.lblPaymentStatus.text = orderStatusPaid
                footerCell.lblPaymentStatus.textColor = .blue
                footerCell.btnRepayment.isHidden = true
            }
            return footerCell
        }
    }
    @objc func actionRepayment(_ sender: UIButton){
        self.moveToNext(PaymentWebViewVC.className,titleStr: objOrderDetailVM.objOrderDetailModel.paymentUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 400
        }
    }
    func updateTotalPrice() -> (Int,Int){
        var finalPrice = Int()
        var quatityFinal = Int()
        for index in 0 ..< objOrderDetailVM.objOrderDetailModel.arrItemModel.count {
            let data = objOrderDetailVM.objOrderDetailModel.arrItemModel[index]
            let price = data.amount
            let quantity = data.quantity
            finalPrice = finalPrice+Int(price)*quantity
            quatityFinal = quatityFinal+quantity
        }
        return (finalPrice,quatityFinal)
    }
}
