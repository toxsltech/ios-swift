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

class SearchListVM: NSObject {
    var searchValue = String()
    var arrPackagesListModel = [PackagesListModel]()
    var totalPage  = 0
    var currentPage  = 0
    
    //MARK:- User Search Api
    func userSeacrhApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.userSearchList(searchText: searchValue).task
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
                        self.arrPackagesListModel = []
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
    
}
//MARK:- CollectionView Delegate Methods
extension SearchListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objSearchListVM.arrPackagesListModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCVC.className , for: indexPath) as! WishListCVC
        let dict = objSearchListVM.arrPackagesListModel[indexPath.row]
        cell.lblAmount.text = "RM\(dict.amount)"
        cell.lblProductName.text = dict.title
        cell.imgVwProducts.sd_setImage(with: URL(string:dict.packageImage ), placeholderImage:#imageLiteral(resourceName: "ic_img2"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2-4, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let objProductDetail = mainStoryboard .instantiateViewController(withIdentifier: ProductDetailVC.className) as! ProductDetailVC
        let dict = objSearchListVM.arrPackagesListModel[indexPath.row]
        objProductDetail.title = "\(dict.id)"
        objProductDetail.objProductDetailVM.typeId = dict.typeId
        objProductDetail.objProductDetailVM.packageDict = dict
        self.navigationController?.pushViewController(objProductDetail, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == objSearchListVM.arrPackagesListModel.count-1 {
            if objSearchListVM.totalPage > objSearchListVM.currentPage+1 {
                objSearchListVM.currentPage += 1
                objSearchListVM.userSeacrhApi() {
                    DispatchQueue.main.async {
                        self.collViewSearchList.reloadData()
                    }
                }
            }
        }
    }
}
extension SearchListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtFldSearch.text! != "" {
            view.endEditing(true)
            let urlString = self.txtFldSearch.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            objSearchListVM.searchValue = urlString!
            searchApi()
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        objSearchListVM.searchValue = ""
        txtFldSearch.text = ""
        searchApi()
        return false
    }
}
