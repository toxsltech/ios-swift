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
import PTCardTabBar


class MainTBC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        if self.title == "cart" {
            DispatchQueue.main.async {
                self.selectedIndex = 2
            }
        }else  if self.title == "wish" {
            DispatchQueue.main.async {
                self.selectedIndex = 1
            }
        }
    }
}


