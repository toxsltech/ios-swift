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

class PaymentMethodTVC: UITableViewCell {
    @IBOutlet weak var lblCardName : UILabel!
    @IBOutlet weak var btnCardDelete : UIButton!
    @IBOutlet weak var imgVwCard : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
