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
import AVKit
import AVFoundation

class HomeVM: NSObject {
    //MARK:- Variables
    var arrSection = ["","Explore by Categories","Packages","Trending"]
    var arrPackagesListModel = [PackagesListModel]()
    var arrBannersImagesModel = [BannersImagesModel]()
    let playerController = AVPlayerViewController()
    var videosArr = [VideosModel]()
    var totalPage  = 0
    var currentPage  = 0
    var userId = Int()
    
    //MARK:- Api Handling
    func getPackagesListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.packageList.task
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
        //MARK:- Api Handling
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
    }
    //MARK:- Api Handling
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
    func getBannerListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.bannerList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objBannersImagesModel = BannersImagesModel()
                                objBannersImagesModel.setDetail(detialDict: detialDict)
                                self.arrBannersImagesModel.append(objBannersImagesModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    //MARK:- Api Handling
    func hitUserSubscriptionPlanApi(_ Id : Int, completion:@escaping() -> Void){
        let result = GetFeaturesService.userSubscriptionPlan(Id).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let detailDict = data["detail"] as? NSDictionary{
                        completion()
                        Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                    }
                }
                
            }
        }
    }
    func getVideosListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getTrendingVideos.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    self.videosArr = []
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objVideosModel = VideosModel()
                                objVideosModel.setDetail(detialDict: detialDict)
                                self.videosArr.append(objVideosModel)
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return objHomeVM.arrSection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVC.className) as! HomeTVC
        cell.reloadVideosCollVwData(self.objHomeVM.videosArr)
        cell.complition = { videoId,videoTitle,showUrl in
            if indexPath.section == 3{
                if showUrl != "" {
                    let videoURL = URL(string: showUrl)
                    let player = AVPlayer(url: videoURL!)
                    self.objHomeVM.playerController.player = player
                    self.present(self.objHomeVM.playerController, animated: true) {
                        self.objHomeVM.playerController.player!.play()
                    }
                }else{
                    Proxy.shared.displayStatusCodeAlert(AlertMessage.noVideo)
                }
            }
        }
        cell.reloadCollVwData(self.objHomeVM.arrPackagesListModel)
        cell.reloadBannerCollVwData(self.objHomeVM.arrBannersImagesModel)
        cell.currentContrl = self
        cell.loadData(section: indexPath.section)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HomeHeaderTVC.className) as! HomeHeaderTVC
        headerCell.lblHeaderName.text = objHomeVM.arrSection[section]
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 210.0
        case 1:
            return 160
        case 2:
            return 170
        case 3:
            return 260.0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 30
    }
}
