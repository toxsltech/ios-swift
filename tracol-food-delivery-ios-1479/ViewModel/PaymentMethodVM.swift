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

class PaymentMethodVM: NSObject {
    //MARK:- Variables
    let arrList = [("Mater Card", "ic_mastercard"),
                   ("Visa","ic_visa"),
                   ("Add Bank","ic_bank")]
    var arrCardListModel = [CardListModel]()
    var selectIndex = -1
    
    //MARK:- Api Handling
    func getCardListApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.cardList.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    self.arrCardListModel = []
                    if let listArr = data["card-details"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objCardListModel = CardListModel()
                                objCardListModel.setDetail(detialDict: detialDict)
                                self.arrCardListModel.append(objCardListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    func userCardDeleteApi(_ id : String,  completion:@escaping() -> Void )  {
        let result = GetFeaturesService.cardDelete(id: id).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                debugPrint("result",response!)
                if let data = response!.data{
                    completion()
                    Proxy.shared.displayStatusCodeAlert( data["message"] as? String ?? "")
                }
            }
        }
    }
}
//MARK:- UITableView Delegate Methods
extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objPaymentMethodVM.arrList.count
            //objPaymentMethodVM.arrCardListModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodTVC.className) as! PaymentMethodTVC
       // let cardDict = objPaymentMethodVM.arrCardListModel[indexPath.row]
        cell.imgVwCard.image = UIImage(named: objPaymentMethodVM.arrList[indexPath.row].1)    
            //UIImage(named:dict.1)
        cell.lblCardName.text = objPaymentMethodVM.arrList[indexPath.row].0
            //cardDict.cardBrand
        cell.btnCardDelete.tag = indexPath.row
        cell.btnCardDelete.addTarget(self, action: #selector(actionDeleteCard), for: .touchUpInside)
        return cell
    }
    @objc func actionDeleteCard(_ sender: UIButton){
       // let cardDict = objPaymentMethodVM.arrCardListModel[sender.tag]
        sender.isSelected.toggle()
       // objPaymentMethodVM.userCardDeleteApi(cardDict.id) {
            self.tblVwCardList.reloadData()
       // }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
