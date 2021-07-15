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

class ConnectsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
    //MARK:- UIActions
       @IBAction func actionWhatsAAp(_ sender: UIButton) {
        if let link = URL(string: "\(whatsAppLink)") {
          UIApplication.shared.open(link)
        }
       }
}
