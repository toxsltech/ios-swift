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
import WebKit

class AboutUsVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnImage: UIButton!
    
    //MARK:- Objects
    let objAboutUsVM = AboutUsVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if title == "Terms" {
            objAboutUsVM.type = PagesConstant.terms.rawValue
            btnImage.setImage(#imageLiteral(resourceName: "ic_backblack"), for: .normal)
            setInitialData()
        } else{
            btnImage.setImage(#imageLiteral(resourceName: "ic_drawer"), for: .normal)
            setInitialData()
        }
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
        if title == "Terms" {
            popToBack()
        }   else{
            KAppDelegate.sideMenu.openLeft()
        }
    }
}
