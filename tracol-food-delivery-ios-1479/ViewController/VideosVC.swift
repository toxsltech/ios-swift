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
import MediaPlayer
import AVKit

class VideosVC: UIViewController,AVPlayerViewControllerDelegate {
    //MARK:- IBOutlets
    @IBOutlet weak var collVwVideos: UICollectionView!
    @IBOutlet weak var btnImage: UIButton!
    
    //MARK:- Objects
    let objVideosVM = VideosVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        objVideosVM.getVideosListApi {
            if self.objVideosVM.videosArr.count == 0 {
                self.noDataFound(self.collVwVideos)
                self.collVwVideos.reloadData()
            }else{
                self.collVwVideos.reloadData()
            }
        }
        if title == "Videos" {
            btnImage.setImage(#imageLiteral(resourceName: "ic_drawer"), for: .normal)
               } else{
            btnImage.setImage(#imageLiteral(resourceName: "ic_backblack"), for: .normal)

                   
               }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        if title == "Videos" {
            KAppDelegate.sideMenu.openLeft()

        } else{
            popToBack()

        }
    }
}
