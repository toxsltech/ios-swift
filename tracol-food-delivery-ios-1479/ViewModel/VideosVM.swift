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
import SDWebImage

class VideosVM: NSObject {
    //MARK:- Variables
    var videosArr = [VideosModel]()
    let playerController = AVPlayerViewController()
    var selectedId = Int()
    var player : AVPlayer?
    var totalPage  = 0
    var currentPage  = 0
    
    //MARK:- Get Videos List Api
    func getVideosListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getVideos.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if self.currentPage == 0 {
                        self.videosArr = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPage  = dictMeta["pageCount"] as! Int
                    }
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
//MARK:- UICollectionView Delegate Methods
extension VideosVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objVideosVM.videosArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: VideosCVC.className, for: indexPath) as! VideosCVC
        let dict = objVideosVM.videosArr[indexPath.row]
        cell.lblTitle.text = dict.title
//        let url = URL(string: dict.bannerVideoUrl)
//        if let thumbnailImage = Proxy.shared.getThumbnailImage(forUrl: url!) {
//            cell.imgViewVideo.image = thumbnailImage
//        }
        cell.imgViewVideo.sd_setImage(with: URL(string:dict.videoImage))
        cell.btnPlayVideo.tag = indexPath.row
        cell.btnPlayVideo.addTarget(self, action: #selector(actionPlay), for: .touchUpInside)
        return cell
    }
    @objc func actionPlay(_sender: UIButton){
        let dict = objVideosVM.videosArr[_sender.tag]
        objVideosVM.playerController.delegate = self
        
        let videoURL = NSURL(string: dict.bannerVideoUrl)
        let player = AVPlayer(url: videoURL! as URL)
        objVideosVM.playerController.player = player
        self.objVideosVM.playerController.player = player
        self.objVideosVM.playerController.showsPlaybackControls = true
        self.present(self.objVideosVM.playerController, animated: true) {
            self.objVideosVM.playerController.player!.play()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2-3, height: 170)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == objVideosVM.videosArr.count-1 {
            if objVideosVM.totalPage > objVideosVM.currentPage+1 {
                objVideosVM.currentPage += 1
                objVideosVM.getVideosListApi() {
                    DispatchQueue.main.async {
                        self.collVwVideos.reloadData()
                    }
                }
            }
        }
    }
}
