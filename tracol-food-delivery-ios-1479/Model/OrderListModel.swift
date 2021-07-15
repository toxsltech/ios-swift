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
class OrderListModel {
    //MARK:- Variables
    var paymentUrl = String()
    var stateId = Int()
    var id = Int()
    var orderId = Int()


    var amount = Int()
    var totalAmount = Int()
    var arrItemModel = [ItemModel]()
    var createdOn = String()
    var date = String()
    var orderStatus = Int()
    var title = String()

    
    func setDetail(detialDict: NSDictionary)  {
        stateId = Proxy.shared.getIntegerValue(detialDict["state_id"] as Any)
        paymentUrl = detialDict["payment_url"] as? String ?? ""
        amount = Proxy.shared.getIntegerValue(detialDict["amount"] as Any)
        stateId = Proxy.shared.getIntegerValue(detialDict["state_id"] as Any)
        totalAmount = Proxy.shared.getIntegerValue(detialDict["total_amount"] as Any)
        createdOn = detialDict["created_on"] as? String ?? ""
        orderStatus = Proxy.shared.getIntegerValue(detialDict["payment_status"] as Any)
        id = Proxy.shared.getIntegerValue(detialDict["id"] as Any)
        orderId = Proxy.shared.getIntegerValue(detialDict["order_id"] as Any)

        title = detialDict["title"] as? String ?? ""

        
        if let dateValue = detialDict["created_on"] as? String {
            date = Proxy.shared.dateConvertDay(date: dateValue, dateFormat: "yyyy-MM-dd HH:mm:ss", getFormat: "dd MMM | h:mm a" )
        } else {
            date =  ""
        }
        if let listArr = detialDict["items"] as? NSArray{
            for dict in listArr{
                if let detialDict = dict as? NSDictionary{
                    let objItemModel = ItemModel()
                    objItemModel.setDetail(detialDict: detialDict)
                    self.arrItemModel.append(objItemModel)
                }
            }
        }
        
    }
}
class ItemModel {
    //MARK:- Variables
    var description = String()
    var itemImg = String()
    var orderId = Int()
    
    var itemId = Int()
    var title = String()
    var amount = Int()
    var quantity = Int()
    var arrOrderListModel = [OrderListModel]()
    
    func setDetail(detialDict: NSDictionary)  {
        amount = Proxy.shared.getIntegerValue(detialDict["amount"] as Any)
        quantity = Proxy.shared.getIntegerValue(detialDict["quantity"] as Any)
        itemId = Proxy.shared.getIntegerValue(detialDict["item_id"] as Any)
        orderId = Proxy.shared.getIntegerValue(detialDict["order_id"] as Any)
        
        if let itemDict = detialDict["item"] as? NSDictionary{
            title = itemDict["title"] as? String ?? ""
            description = itemDict["description"] as? String ?? ""
            itemImg = "\(ApiImgUrl.imgUrl)\(itemDict["image_file"] as? String ?? "")"
        }
    }
}
