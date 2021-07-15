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

class MyOrdersTVC: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblOrderId : UILabel!
    @IBOutlet weak var lblOrderStatus : UILabel!
    @IBOutlet weak var lblShowDate : UILabel!
    @IBOutlet weak var imgViewOrder : UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
