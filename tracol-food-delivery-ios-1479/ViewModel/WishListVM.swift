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

class WishListVM: NSObject {
    //MARK:- Variables
    var PackagesListModelArr = [PackagesListModel]()
    var selectValue = -1
    var selectedId = Int()
    var selectedtab = 2
    //MARK:- Get Country List Api
    func packagesFavouriteListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.favouriteList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let listArr = data["list"] as? NSArray{
                        self.PackagesListModelArr = []
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objPackagesListModel = PackagesListModel()
                                objPackagesListModel.setDetail(detialDict: detialDict)
                                self.PackagesListModelArr.append(objPackagesListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    //MARK:- Get Country List Api
    func productsFavouriteListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.packageFavouriteList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let listArr = data["list"] as? NSArray{
                        self.PackagesListModelArr = []
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objPackagesListModel = PackagesListModel()
                                objPackagesListModel.setDetail(detialDict: detialDict)
                                self.PackagesListModelArr.append(objPackagesListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
}
//MARK:- CollectionView Delegate Methods
extension WishListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.objWishListVM.PackagesListModelArr.count == 0 {                    self.noDataFound(self.collViewWishList)
        }else{
            collectionView.backgroundView = nil
        }
        return objWishListVM.PackagesListModelArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCVC.className , for: indexPath) as! WishListCVC
        let dict = objWishListVM.PackagesListModelArr[indexPath.row]
        cell.lblAmount.text = "\(currency) \(dict.amount)"
        cell.lblProductName.text = dict.title
        cell.imgVwProducts.sd_setImage(with: URL(string:dict.packageImage ), placeholderImage:#imageLiteral(resourceName: "ic_img2"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2-4, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objProductDetail = mainStoryboard .instantiateViewController(withIdentifier: ProductDetailVC.className) as! ProductDetailVC
        let productDict = objWishListVM.PackagesListModelArr[indexPath.row]
        objProductDetail.title = "\(productDict.id)"
        objProductDetail.objProductDetailVM.typeId = productDict.typeId
        objProductDetail.objProductDetailVM.packageDict = productDict
        self.navigationController?.pushViewController(objProductDetail, animated: true)
    }
}
