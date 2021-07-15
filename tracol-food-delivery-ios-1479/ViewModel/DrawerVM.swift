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

class DrawerVM: NSObject {
    //MARK:- Variables
    let arrList = [("Home",KRTabBarController.className),
                   ("My Order",MyOrdersVC.className),
                   ("My Addresses",AddressListVC.className),
                   //("Payment",PaymentMethodVC.className),
        ("Charity",CharityListVC.className),
        ("Videos",VideosVC.className),
        ("Wishtlist",KRTabBarController.className),
        ("Settings",SettingsVC.className),
        ("About Us",AboutUsVC.className),
        ("Terms & Conditions",AboutUsVC.className),
        ("Privacy Policy",AboutUsVC.className),
        ("Contact Us",ContactUsVC.className)]
    //MARK:- Api Handling
    func logoutUserApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.logout.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                objUserModel = UserModel()
                UserDefaults.standard.set("", forKey: "access-token")
                UserDefaults.standard.synchronize()
                completion()
                Proxy.shared.displayStatusCodeAlert(AlertMessage.logoutSuccess)
            }
        }
    }
}
//MARK:- TableView Delegates Methods
extension DrawerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objDrawerVM.arrList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerTVC") as!
        DrawerTVC
        cell.lblName.text = objDrawerVM.arrList[indexPath.row].0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5{
            RootControllerProxy.shared.rootWithDrawer(objDrawerVM.arrList[indexPath.row].1, titleStr: "wish")
        }else if indexPath.row == 3{
            
            if let url = URL(string: "\(charityLink)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let vc = SFSafariViewController(url: url, configuration: config)
                self.present(vc, animated: true)
            }
        }else{
            RootControllerProxy.shared.rootWithDrawer(objDrawerVM.arrList[indexPath.row].1, titleStr: objDrawerVM.arrList[indexPath.row].0 )
        }
        
    }
}
