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

class DoctorVC: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var imgViewCategories: UIImageView!
    //MARK:- UIView Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if  title == "Takaful"{
            imgViewCategories.image = UIImage(named: "ic_three")
            vwBackground.backgroundColor = #colorLiteral(red: 0.280629158, green: 0.6768341064, blue: 0.312825799, alpha: 1)

        } else if  title == "Logistic"{
            imgViewCategories.image = UIImage(named: "ic_one-1")
            vwBackground.backgroundColor = #colorLiteral(red: 0.1067364588, green: 0.009779920802, blue: 0.3306696415, alpha: 1)
        } else if  title == "Pay"{
            imgViewCategories.image = UIImage(named: "ic_two")
            vwBackground.backgroundColor = #colorLiteral(red: 0.2407883108, green: 0.3501597345, blue: 0.6534306407, alpha: 1)

        } else if  title == "Travel"{
            imgViewCategories.image = UIImage(named: "ic_four")
        }
    }
    //MARK:- UIActions
    @IBAction func actionBack(_ sender: UIButton) {
        popToBack()
    }
}
