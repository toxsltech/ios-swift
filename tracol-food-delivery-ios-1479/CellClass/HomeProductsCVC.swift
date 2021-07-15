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

class HomeProductsCVC: UICollectionViewCell {
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var imgVwProducts : UIImageView!
    @IBOutlet weak var lblAmount : UILabel!
    @IBOutlet weak var btnFavUnFav : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
