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

class CharityListVM: NSObject {
    var arrCharityDetailModel = [CharityDetailModel]()
    
    //MARK:- Api Handling
    func getCharityListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getCharity.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objCharityDetailModel = CharityDetailModel()
                                objCharityDetailModel.setDetail(detialDict)
                                self.arrCharityDetailModel.append(objCharityDetailModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
}
//MARK:- UITableView delegate methods
extension CharityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCharityListVM.arrCharityDetailModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharityTVC.className) as! CharityTVC
        let dict = objCharityListVM.arrCharityDetailModel[indexPath.row]
        cell.lblTitle.text = dict.title
        cell.lblDescription.text = dict.description
        cell.imgViewCharity.sd_setImage(with: URL(string:dict.charityImg), placeholderImage:#imageLiteral(resourceName: "ic_fruit"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objCharityVC = mainStoryboard .instantiateViewController(withIdentifier: CharityVC.className) as! CharityVC
        let dict = objCharityListVM.arrCharityDetailModel[indexPath.row]
        objCharityVC.objCharityVM.charityDict = dict
        self.navigationController?.pushViewController(objCharityVC, animated: true)
    }
}
