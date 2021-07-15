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
import AVFoundation
import AVKit
import SDWebImage
import SafariServices



class HomeTVC: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var collViewItems: UICollectionView!
    
    //MARK:- Objects
    let objHomeVM = HomeVM()
    let selectedId = Int()
    var currentContrl = UIViewController()
    var arrPackage = [PackagesListModel]()
    var arrBanner = [BannersImagesModel]()
    var arrVideos = [VideosModel]()
    let playerViewController = AVPlayerViewController()
    var complition : completionHandler?
    typealias completionHandler = (_ videoId: Int, _ videoTitle : String, _ urlStr: String) -> Void
    
    //MARK:- Variables
    var indexSection = 0
    let arrList = [("Connect", "ic_doctor"),
                   ("Fruits","ic_fruit"),
                   ("Community","ic_community"),
                   ("Takaful","ic_takeawy"),
                   ("Logistic","ic_logistic"),
                   ("",""),
                   ("Education","ic_tracoledu"),
                   ("Amanah","ic_one"),
                   ("Pay","ic_tracolpay"),
                   ("Travel","ic_tracoltravel"),("","")]
    
    //MARK:- UIview LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        Proxy.shared.registerCollViewNib(collViewItems, identifierCell: HomeBannerCVC.className)
        Proxy.shared.registerCollViewNib(collViewItems, identifierCell: HomeCategoryCVC.className)
        Proxy.shared.registerCollViewNib(collViewItems, identifierCell: HomeProductsCVC.className)
        Proxy.shared.registerCollViewNib(collViewItems, identifierCell: HomeTrendingCVC.className)
    }
    func reloadCollVwData(_ arr: [PackagesListModel]) {
        arrPackage = arr
        collViewItems.reloadData()
    }
    func reloadBannerCollVwData(_ arr: [BannersImagesModel]) {
        arrBanner = arr
        collViewItems.reloadData()
    }
    func reloadVideosCollVwData(_ arr: [VideosModel]) {
        arrVideos = arr
        collViewItems.reloadData()
    }
    func loadData(section: Int) {
        indexSection = section
        if indexSection == 1 {
            if let flowLayout = collViewItems.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
        }else{
            if let flowLayout = collViewItems.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
        }
        collViewItems.delegate = self
        collViewItems.dataSource = self
        collViewItems.reloadData()
    }
}
//MARK: UICollectionView Delegate methods
extension HomeTVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch indexSection {
        case 0:
            return 1
        //arrBanner.count
        case 1:
            return arrList.count
        case 2:
            return arrPackage.count
        case 3:
            return arrVideos.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexSection {
        case 0:
            let cellBanner = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCVC.className, for: indexPath) as! HomeBannerCVC
            //            let bannerDict = arrBanner[indexPath.row]
            //            cellBanner.lblTitle.text = bannerDict.title
            //            cellBanner.imgVwBanners.sd_setImage(with: URL(string:bannerDict.bannerImg), placeholderImage:#imageLiteral(resourceName: "ic_img1"))
            cellBanner.btnOrderNow.tag = indexPath.row
            cellBanner.btnOrderNow.addTarget(self, action: #selector(actionOrderNow), for: .touchUpInside)
            return cellBanner
        case 1:
            let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCVC.className, for: indexPath) as! HomeCategoryCVC
            cellCategory.lblTitle.text = arrList[indexPath.row].0
            cellCategory.imgVwCategory.image =  UIImage(named: arrList[indexPath.row].1)
            return cellCategory
        case 2:
            let cellProducts = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductsCVC.className, for: indexPath) as!
            HomeProductsCVC
            let productDict = arrPackage[indexPath.row]
            cellProducts.lblProductName.text = productDict.title
            cellProducts.lblAmount.text = "\(currency) \(productDict.amount)"
            cellProducts.imgVwProducts.sd_setImage(with: URL(string:productDict.packageImage ), placeholderImage:#imageLiteral(resourceName: "ic_img2"))
            if productDict.favourite == 0 {
                cellProducts.btnFavUnFav.setImage(#imageLiteral(resourceName: "ic_unfav"), for: .normal)
            }else{
                cellProducts.btnFavUnFav.setImage(#imageLiteral(resourceName: "ic_fav"), for: .normal)
            }
            cellProducts.btnFavUnFav.tag = indexPath.row
            cellProducts.btnFavUnFav.addTarget(self, action: #selector(actionFavourite), for: .touchUpInside)
            return cellProducts
        case 3:
            let cellTrending = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTrendingCVC.className, for: indexPath) as! HomeTrendingCVC
            let videoDict = arrVideos[indexPath.row]
            cellTrending.lblTitle.text = videoDict.title
            cellTrending.btnPlayVideo.tag = indexPath.row
            cellTrending.imgViewVideo.sd_setImage(with: URL(string:videoDict.videoImage))
//            let url = URL(string: videoDict.bannerVideoUrl)
//            if let thumbnailImage = Proxy.shared.getThumbnailImage(forUrl: url!) {
//                cellTrending.imgViewVideo.image = thumbnailImage
//            }
            cellTrending.btnPlayVideo.addTarget(self, action: #selector(actionPlay), for: .touchUpInside)
            return cellTrending
        default:
            return UICollectionViewCell()
        }
    }
    @objc func actionFavourite(_ Sender: UIButton) {
        let productDict = arrPackage[Sender.tag]
        objHomeVM.userFavApi(productDict.id) {
            productDict.favourite = productDict.favourite == 0 ? 1 : 0
            self.collViewItems.reloadData()
        }
    }
    @objc func actionOrderNow(_ Sender: UIButton) {
        currentContrl.moveToNext(ProductListVC.className)
        
    }
    @objc func actionPlay(_ sender: UIButton){
        var finalDict = VideosModel()
        guard let finalComp = complition else {
            return
        }
        finalDict = arrVideos[sender.tag]
        finalComp(finalDict.id, finalDict.title, finalDict.bannerVideoUrl)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexSection {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        case 1:
            if indexPath.item < 5 {
                return CGSize(width: collectionView.frame.size.width/5-5, height: collectionView.frame.size.height/2)
            } else if indexPath.item == 5 || indexPath.item == 10 {
                return CGSize(width: 30, height: collectionView.frame.size.height/2)
            }
            else {
                return CGSize(width: collectionView.frame.size.width/4.8, height: collectionView.frame.size.height/2)
            }
        case 2:
            return CGSize(width: collectionView.frame.size.width/2.2, height: 170)
        case 3:
            return CGSize(width: collectionView.frame.size.width, height: 260)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexSection == 1 {
            switch indexPath.item {
            case 0:
                currentContrl.moveToNext(ConnectsVC.className, titleStr: "Doctor")
            case 1:
                currentContrl.moveToNext(ProductListVC.className)
            case 2:
                if let link = URL(string: "\(communityLink)") {
                    UIApplication.shared.open(link)
                }
            case 3:
                currentContrl.moveToNext(DoctorVC.className, titleStr: "Takaful")
            case 4:
                currentContrl.moveToNext(DoctorVC.className, titleStr: "Logistic")
            case 5,10:
                break
            case 6:
                currentContrl.moveToNext(VideosVC.className)
            case 7:
                
                  if let url = URL(string: "\(charityLink)") {
                                let config = SFSafariViewController.Configuration()
                                config.entersReaderIfAvailable = true

                                let vc = SFSafariViewController(url: url, configuration: config)
                    //KAppDelegate.window(vc, animated: true)
                    currentContrl.present(vc, animated: true)
                            }
                //currentContrl.moveToNext(CharityListVC.className)
            case 8:
                currentContrl.moveToNext(DoctorVC.className, titleStr: "Pay")
            case 9:
                currentContrl.moveToNext(DoctorVC.className, titleStr: "Travel")
            default:
                break
            }
        }
        else if indexSection == 2 {
            let objProductDetail = mainStoryboard .instantiateViewController(withIdentifier: ProductDetailVC.className) as! ProductDetailVC
            let productDict = arrPackage[indexPath.row]
            objProductDetail.title = "\(productDict.id)"
            objProductDetail.objProductDetailVM.typeId = PackajTypeId.package.rawValue
            objProductDetail.objProductDetailVM.packageDict = productDict
            self.currentContrl.navigationController?.pushViewController(objProductDetail, animated: true)
        }
    }
}
