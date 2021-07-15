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

class ProductDetailVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    
    //MARK:- Objects
    let objProductDetailVM = ProductDetailVM()
    var context:NSManagedObjectContext!
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        lblProductName.text = objProductDetailVM.packageDict.title
        objProductDetailVM.packageDict.typeId = objProductDetailVM.typeId
        lblDiscription.text = objProductDetailVM.packageDict.discription
        lblHeader.text = objProductDetailVM.packageDict.title
        lblPrice.text = "\(currency) \(objProductDetailVM.packageDict.amount)"
        
        
        if objProductDetailVM.packageDict.favourite == 0 {
            btnFav.setImage(#imageLiteral(resourceName: "ic_unfav"), for: .normal)
        }else{
            btnFav.setImage(#imageLiteral(resourceName: "ic_fav"), for: .normal)
        }
        imgViewProduct.sd_setImage(with: URL(string:objProductDetailVM.packageDict.packageImage), placeholderImage:#imageLiteral(resourceName: "placeholder"))
        openDatabse()
        fetchData()
        
        let dictProduct = objProductDetailVM.packageDict
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", dictProduct.id)
        let predicate2 = NSPredicate(format: "typeId = %d", dictProduct.typeId)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        do {
            let results = try context.fetch(fetchRequest)
            if results.count>0 {
                let cart = results.first as! Cart
                debugPrint(cart)
                if objProductDetailVM.packageDict.id == cart.value(forKey: "id") as! Int{
                    let itemQuantity = cart.value(forKey: "quantity") as! Int
                    
                    lblCartCount.text = "\(itemQuantity)"
                }else{}
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    @IBAction func actionFavourite(_ Sender: UIButton) {
        if  objProductDetailVM.typeId == PackajTypeId.product.rawValue {
            let productDict = objProductDetailVM.packageDict
            objProductDetailVM.productVM.productsFavApi(productDict.id) {
                productDict.favourite = productDict.favourite == 0 ? 1 : 0
                if self.objProductDetailVM.packageDict.favourite == 0 {
                    self.btnFav.setImage(#imageLiteral(resourceName: "ic_unfav"), for: .normal)
                }else{
                    self.btnFav.setImage(#imageLiteral(resourceName: "ic_fav"), for: .normal)
                }
            }
        }else {
            let packageDict = objProductDetailVM.packageDict
            objProductDetailVM.productVM.userFavApi(packageDict.id) {
                packageDict.favourite = packageDict.favourite == 0 ? 1 : 0
                if self.objProductDetailVM.packageDict.favourite == 0 {
                    self.btnFav.setImage(#imageLiteral(resourceName: "ic_unfav"), for: .normal)
                }else{
                    self.btnFav.setImage(#imageLiteral(resourceName: "ic_fav"), for: .normal)
                }
            }
        }
    }
    //MARK:- UIActions
    @IBAction func actionAddCart(_ sender: UIButton) {
        if lblCartCount.text == "0" {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.addCart)
        }else{
            RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className,titleStr: "cart")
        }
    }
    @IBAction func actionAdd(_ sender: UIButton) {
        openDatabse()
        fetchData()
        let dictProduct = objProductDetailVM.packageDict
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
                lblCartCount.text = "\(itemQuantity)"
            }else {
                if sender.tag == 1{
                    checkCartValue(productDet: dictProduct)
                }
            }
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    //MARK:- Core data methods
    func fetchData()  {
        context = KAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)
        } catch {
            Proxy.shared.displayStatusCodeAlert("Fetching data Failed")
        }
    }
    func openDatabse() {
        context = KAppDelegate.persistentContainer.viewContext
    }
    func checkCartValue(productDet:PackagesListModel){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", productDet.id)
        let predicate2 = NSPredicate(format: "typeId = %d", productDet.typeId)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count>0 {
                let results = try context.fetch(fetchRequest)
                let cart = results.first as! Cart
                debugPrint(cart)
                updateCart(cart: cart, productDet: productDet)
            } else {
                lblCartCount.text = "1"
                saveData(productDet: productDet)
            }
            // fetchData()
        } catch {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.tryAgain)
        }
    }
    func updateCart(cart:NSManagedObject, productDet:PackagesListModel){
        let itemQuantity = productDet.quantity
        debugPrint(cart)
        do {
            if itemQuantity == 0 {
                context.delete(cart)
            } else {
                cart.setValue(itemQuantity, forKey: "quantity")
            }
            try context.save()
        } catch {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.tryAgain)
        }
    }
    func saveData(productDet:PackagesListModel){
        
        //if Int(lblCartCount.text!)! < productDet.quantity {
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
            
        } catch {
            Proxy.shared.displayStatusCodeAlert(AlertMessage.tryAgain)
        }
        //}
    }
    
    func updateQuntity(productDet:PackagesListModel) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate1 = NSPredicate(format: "id = %d", productDet.id)
        let predicate2 = NSPredicate(format: "typeId = %d", productDet.typeId)
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        
        var results: [NSManagedObject] = []
        do {
            results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if results.count>0 {
                let cart = results.first as! Cart
                // productDet.quantity = cart.value(forKey: "quantity") as? Int ?? 0
            } else {
                // productDet.quantity = 0
            }
        }
        catch {
            //  Proxy.shared.displayStatusAlert(message: "error executing fetch request: \(error)", state: .error)
        }
        return productDet.quantity
    }
}
