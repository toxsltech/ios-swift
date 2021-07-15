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

class NotificationsVM: NSObject {
    //MARK:- Variables
    var NotficationListModelArr = [NotficationListModel]()
    var selectValue = -1
    var selectedId = Int()
    //MARK:- Get Country List Api
    func getNotificationListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getNotificationList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let listArr = data["list"] as? NSArray{
                        self.NotficationListModelArr = []
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objNotficationListModel = NotficationListModel()
                                objNotficationListModel.setDetail(detialDict: detialDict)
                                self.NotficationListModelArr.append(objNotficationListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
}
//MARK:- UITableView Delegate Methods
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objNotificationsVM.NotficationListModelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTVC.className) as! NotificationsTVC
        let dict = objNotificationsVM.NotficationListModelArr[indexPath.row]
        cell.lblTitle.text = dict.title
        cell.lblDate.text = dict.date
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objOrderDetailVC = mainStoryboard.instantiateViewController(withIdentifier: OrderDetailVC.className) as! OrderDetailVC
        let dict = objNotificationsVM.NotficationListModelArr[indexPath.row]
        //objOrderDetailVC.title = "Notification"
        objOrderDetailVC.title = "\(dict.modelId)"

        self.navigationController?.pushViewController(objOrderDetailVC, animated: true)
    }
}
