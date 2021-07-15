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

class CheckOutFooterTVC: UITableViewCell {
    //MARK:- IBOtlets
    @IBOutlet weak var lblItemsQuantity: UILabel!
    @IBOutlet weak var lblItemsQuantityPrice: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblDeliveryCharges: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnTick: UIButton!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var btnRepayment: UIButton!
    @IBOutlet weak var lblPaymentStatus: UILabel!
}
