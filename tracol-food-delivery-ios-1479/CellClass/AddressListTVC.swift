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

class AddressListTVC: UITableViewCell {
    @IBOutlet weak var lblAdreess : UILabel!
    @IBOutlet weak var lblContactNumber : UILabel!
    @IBOutlet weak var lblZipCode : UILabel!
    @IBOutlet weak var btnTick : UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnEdit : UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
