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
import SafariServices

class CharityVC: UIViewController {
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGoalAmount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewCharity: UIImageView!
    
    
    let objCharityVM = CharityVM()
    
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //objCharityVM.getCharityApi {
            self.lblDescription.text! = objCharityVM.charityDict.description
            self.lblTitle.text! = objCharityVM.charityDict.title
            self.lblGoalAmount.text! = "\(currency) \(objCharityVM.charityDict.raisedAmount) raised of \(currency) \(objCharityVM.charityDict.goalAmount)"
            self.imgViewCharity.sd_setImage(with: URL(string:objCharityVM.charityDict.charityImg ), placeholderImage:#imageLiteral(resourceName: "ic_imgnew"))
        //}
    }
    //MARK:- UIActions
    @IBAction func actionDrawer(_ sender: UIButton) {
            popToBack()
    }
    @IBAction func actionDonation(_ sender: UIButton) {
        view.endEditing(true)
        let controllerPresent  = self.storyboard?.instantiateViewController(withIdentifier: DonationVC.className) as! DonationVC
        controllerPresent.charityId = objCharityVM.charityDict.id
        controllerPresent.complition = {
            title in
            if title == "TermCondition"{
                self.moveToNext(AboutUsVC.className,titleStr: "Terms")
            } else if title != ""{
                
                if let url = URL(string: title) {
                    let config = SFSafariViewController.Configuration()
                    config.entersReaderIfAvailable = true

                    let vc = SFSafariViewController(url: url, configuration: config)
                    vc.delegate = self
                    self.present(vc, animated: true)
                }
              //  self.moveToNext(PaymentWebViewVC.className,titleStr: title)
            }
        }
        self.navigationController!.present(controllerPresent, animated: true)
    }
    @IBAction func actionShare(_ sender: UIButton) {
        let text = objCharityVM.charityDict.shareUrl
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
}
extension CharityVC: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // Dismiss the SafariViewController when done
        print("safariViewControllerDidFinish")
        RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)

    }
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print("safariViewController",URL)
    }
//    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
//
//    }
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
                print("didCompleteInitialLoad")

    }
    
//    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
//        <#code#>
//    }
}
