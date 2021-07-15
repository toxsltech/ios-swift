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

class CheckOutVM: NSObject {
    //MARK:- Variables
    var arrCartList = [NSManagedObject]()
    let objAddCartVM = AddCartVM()
    var totalCartPrice = Double()
    var isEdited = false
    var isTerms = false
    var titleTerms = String()
}
//MARK:- UITableView Delegate Methods
extension CheckOutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? objCheckOutVM.objAddCartVM.arrCartList.count : 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddCartTVC.className) as! AddCartTVC
            let data = objCheckOutVM.objAddCartVM.arrCartList[indexPath.row]
            
            let price = data.value(forKey: "price") as? String ?? "0"
            let quantity = data.value(forKey: "quantity") as? Int ?? 0
            cell.lblProductName.text = data.value(forKey: "itemName") as? String
            cell.lblPrice.text = "\(currency) \(Int(price)!*quantity)"
            cell.lblQuantity.text = "\(data.value(forKey: "quantity") as? Int ?? 0)"
            cell.imgViewProduct.sd_setImage(with: URL(string: (data.value(forKey: "itemImg") as? String ?? "")), placeholderImage: UIImage(named: "ic_img2"))
            cell.btnPlus.tag = indexPath.row
            cell.btnMinus.tag = indexPath.row
            cell.btnMinus.addTarget(self, action: #selector(updateCartQuantity(_:)), for: .touchUpInside)
            cell.btnPlus.addTarget(self, action: #selector(updateCartQuantity(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let footerCell = tableView.dequeueReusableCell(withIdentifier: CheckOutFooterTVC.className) as! CheckOutFooterTVC
            footerCell.lblItemsQuantity.text = "Items: \(objCheckOutVM.objAddCartVM.arrCartList.count)"
            footerCell.lblItemsQuantityPrice.text = "\(currency) \(updateTotalPrice().0)"
            footerCell.lblItemPrice.text = "\(currency) \(updateTotalPrice().0)"
            // footerCell.lblTotal.text = "\(currency) \(updateTotalPrice().0)"
            footerCell.lblDeliveryCharges.text = "\(currency) \(objUserModel.deliveryCharges) * \(updateTotalPrice().1)"
            let finalDelivery = objUserModel.deliveryCharges*updateTotalPrice().1
            footerCell.lblTotal.text = "\(currency) \(updateTotalPrice().0+finalDelivery)"
            footerCell.btnTick.tag = indexPath.row
            footerCell.btnPlaceOrder.tag = indexPath.row
            footerCell.btnTick.addTarget(self, action: #selector(actionTick), for: .touchUpInside)
            footerCell.btnPlaceOrder.addTarget(self, action: #selector(actionPlaceOrder), for: .touchUpInside)
            return footerCell
        }
    }
    @objc func actionTick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        objCheckOutVM.isTerms = sender.isSelected
    }
    @objc func actionPlaceOrder(_ sender: UIButton) {
        if  objCheckOutVM.isTerms == true{
            let objPaymentDetailVC = mainStoryboard.instantiateViewController(withIdentifier: PaymentDetailVC.className) as! PaymentDetailVC
            objPaymentDetailVC.objPaymentDetailVM.arrCartList = objCheckOutVM.objAddCartVM.arrCartList
            self.navigationController?.pushViewController(objPaymentDetailVC, animated: true)
        }else {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.acceptTermsCondition)
        }
    }
    //MARK:- Update cart quantity
    //    @objc func updateCartQuantity(_ sender: UIButton){
    //        objAddCartVM.isEdited = true
    //        let data = objAddCartVM.arrCartList[sender.tag]
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
    //        fetchRequest.predicate = NSPredicate(format: "id = %d", data.value(forKey: "id") as! Int)
    //        do {
    //            let results = try context.fetch(fetchRequest)
    //            if results.count>0 {
    //                let cart = results.first as! Cart
    //                debugPrint(cart)
    //                var itemQuantity = cart.value(forKey: "quantity") as! Int
    //                let plusImg = UIImage(named: "ic_plus")
    //                if sender.currentImage!.pngData() == plusImg!.pngData(){
    //                    itemQuantity = itemQuantity+1
    //                    cart.setValue(itemQuantity, forKey: "quantity")
    //                    try context.save()
    //                } else {
    //                    if itemQuantity > 0 {
    //                        itemQuantity = itemQuantity-1
    //                        cart.setValue(itemQuantity, forKey: "quantity")
    //                        try context.save()
    //                    }
    //                }
    //            }
    //
    //        } catch let error as NSError {
    //            print("Could not fetch. \(error), \(error.userInfo)")
    //        }
    //        fetchData()
    //    }
    @objc func updateCartQuantity(_ sender: UIButton){
        objCheckOutVM.objAddCartVM.isEdited = true
        let data = objCheckOutVM.objAddCartVM.arrCartList[sender.tag]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        //fetchRequest.predicate = NSPredicate(format: "id = %d", data.value(forKey: "id") as! Int)
        let predicate1 = NSPredicate(format: "id = %d", data.value(forKey: "id") as! Int)
        let predicate2 = NSPredicate(format: "typeId = %d", data.value(forKey: "typeId") as! Int)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count>0 {
                let cart = results.first as! Cart
                debugPrint(cart)
                var itemQuantity = cart.value(forKey: "quantity") as! Int
                let plusImg = UIImage(named: "ic_plus")
                if sender.currentImage!.pngData() == plusImg!.pngData(){
                    itemQuantity = itemQuantity+1
                    cart.setValue(itemQuantity, forKey: "quantity")
                    try context.save()
                } else {
                    if itemQuantity > 1 {
                        itemQuantity = itemQuantity-1
                        cart.setValue(itemQuantity, forKey: "quantity")
                        try context.save()
                    }else{
                        context.delete(cart)
                        try context.save()
                    }
                }
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
        fetchData()
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
        
        for index in 0 ..< objCheckOutVM.objAddCartVM.arrCartList.count {
            let data = objCheckOutVM.objAddCartVM.arrCartList[index]
            let price = data.value(forKey: "price") as? String ?? "0"
            let quantity = data.value(forKey: "quantity") as? Int ?? 0
            finalPrice = finalPrice+Int(price)!*quantity
            quatityFinal = quatityFinal+quantity
        }
        return (finalPrice,quatityFinal)
    }
}
