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

class CharityVM: NSObject {
    //MARK:- Variables
    let titleVal = String()
    var charityDict = CharityDetailModel()
    
    //MARK:- Get Videos List Api
    func getCharityApi(_ completion:@escaping() -> Void )  {
        let result = GetFeaturesService.getCharity.task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let dataVal = data["detail"] as? NSDictionary{
                        objCharityDetailModel.setDetail(dataVal)
                        completion()
                    }
                }
                
            }
        }
    }
}
