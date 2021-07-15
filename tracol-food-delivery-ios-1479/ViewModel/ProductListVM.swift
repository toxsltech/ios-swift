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
class ProductListVM: NSObject {
    //MARK:- Variables
    var arrPackagesListModel = [PackagesListModel]()
    var totalPage  = 0
    var currentPage  = 0
    
    //MARK:- Api Handling
    func getFruitListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.productList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if self.currentPage == 0 {
                        self.arrPackagesListModel = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPage  = dictMeta["pageCount"] as! Int
                    }
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objPackagesListModel = PackagesListModel()
                                objPackagesListModel.setDetail(detialDict: detialDict)
                                self.arrPackagesListModel.append(objPackagesListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    func userFavApi(_ id : Int,  completion:@escaping() -> Void )  {
        let result = AccountService.userFav(id: id).task
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
    
    //MARK:- Api Handling
    func productsFavApi(_ id : Int,  completion:@escaping() -> Void )  {
        let result = AccountService.productsFav(id: id).task
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
//MARK:- UICollectionView Delegates methods
extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objProductListVM.arrPackagesListModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCVC.className, for: indexPath) as! ProductListCVC
        let dict = objProductListVM.arrPackagesListModel[indexPath.row]
        cell.lblProductName.text = dict.title
        cell.lblDescription.text = dict.discription
        cell.lblPrice.text = "\(currency) \(dict.amount)"
        cell.btnViewDetails.tag = indexPath.row
        cell.imgVwProducts.sd_setImage(with: URL(string:dict.packageImage), placeholderImage:#imageLiteral(resourceName: "placeholder"))
        cell.btnAddCart.tag = indexPath.row
        cell.btnFavourite.tag = indexPath.row
        if dict.favourite == 0 {
            cell.btnFavourite.setImage(#imageLiteral(resourceName: "ic_unfav"), for: .normal)
        }else{
            cell.btnFavourite.setImage(#imageLiteral(resourceName: "ic_fav"), for: .normal)
        }
        cell.btnAddCart.addTarget(self, action: #selector(actionAddCart), for: .touchUpInside)
        cell.btnFavourite.addTarget(self, action: #selector(actionFavourite), for: .touchUpInside)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", dict.id)
        let predicate2 = NSPredicate(format: "typeId = %d", dict.typeId)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        
        do {
            let results = try KAppDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            if results.count>0 {
                //HIDE
                cell.btnAddCart.isHidden = true
            }else {
                //SHOWW
                cell.btnAddCart.isHidden = false
                
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
        return cell
    }
    @objc func actionAddCart(_ sender: UIButton) {
        openDatabse()
        fetchData()
        let dictProduct = objProductListVM.arrPackagesListModel[sender.tag]
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", dictProduct.id)
        let predicate2 = NSPredicate(format: "typeId = %d", dictProduct.typeId)
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
                    dictProduct.quantity = itemQuantity
                    try context.save()
                } else {
                    if itemQuantity > 0 {
                        itemQuantity = itemQuantity-1
                        if itemQuantity == 0{
                            context.delete(cart)
                        }else{
                            cart.setValue(itemQuantity, forKey: "quantity")
                            //  dictProduct.quantity = itemQuantity
                            try context.save()
                        }
                    }
                }
            }else {
                checkCartValue(productDet: dictProduct)
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    @objc func actionFavourite(_ Sender: UIButton) {
        let dict = objProductListVM.arrPackagesListModel[Sender.tag]
        objProductListVM.productsFavApi(dict.id) {
            dict.favourite = dict.favourite == 0 ? 1 : 0
            self.collViewFruitList.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/1.1, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objProductDetail = mainStoryboard .instantiateViewController(withIdentifier: ProductDetailVC.className) as! ProductDetailVC
        let productDict = objProductListVM.arrPackagesListModel[indexPath.row]
        objProductDetail.title = "\(productDict.id)"
        objProductDetail.objProductDetailVM.packageDict = productDict
        objProductDetail.objProductDetailVM.typeId = PackajTypeId.product.rawValue
        self.navigationController?.pushViewController(objProductDetail, animated: true)
    }
    func checkCartValue(productDet:PackagesListModel){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", productDet.id)
        let predicate2 = NSPredicate(format: "typeId = %d", productDet.typeId)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        
        do {
            let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
            let newCart = NSManagedObject(entity: entity!, insertInto: context)
            let quantity = 1
            newCart.setValue(productDet.title, forKey: "itemName")
            newCart.setValue(productDet.packageImage, forKey: "itemImg")
            newCart.setValue(quantity, forKey: "quantity")
            newCart.setValue("\(productDet.amount)", forKey: "price")
            newCart.setValue("\(Date())", forKey: "createdOn")
            newCart.setValue(productDet.id, forKey: "id")
            newCart.setValue(productDet.typeId, forKey: "typeId")
            do {
                try context.save()
                Proxy.shared.displayStatusCodeAlert(AlertMessage.itemAdded)
                collViewFruitList.reloadData()
                getCartCountFromCoreData()
                
            } catch {
                Proxy.shared.displayStatusCodeAlert(AlertMessage.tryAgain)
            }
            
        } catch {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.tryAgain)
        }
    }
}
