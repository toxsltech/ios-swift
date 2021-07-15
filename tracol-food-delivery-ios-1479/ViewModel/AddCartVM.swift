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

class AddCartVM: NSObject {
    //MARK:- Variables
    var arrCartList = [NSManagedObject]()
    var totalCartPrice = Double()
    var isEdited = false
}
//MARK:- UITableView Delegate Methods
extension AddCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objAddCartVM.arrCartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddCartTVC.className) as! AddCartTVC
        let data = objAddCartVM.arrCartList[indexPath.row]
        
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
    }
    //MARK:- Update cart quantity
    @objc func updateCartQuantity(_ sender: UIButton){
        objAddCartVM.isEdited = true
        let data = objAddCartVM.arrCartList[sender.tag]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        // fetchRequest.predicate = NSPredicate(format: "id = %d", data.value(forKey: "id") as! Int)
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
                        DispatchQueue.main.async {
                            self.deleteAlert(AlertMessage.removeItem){_ in
                                do {
                                    self.context.delete(cart)
                                    try self.context.save()
                                    self.objAddCartVM.arrCartList.remove(at: sender.tag)
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
                                    
                                }
                                catch{
                                }
                            }
                        }
                    }
                }
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
        fetchData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
