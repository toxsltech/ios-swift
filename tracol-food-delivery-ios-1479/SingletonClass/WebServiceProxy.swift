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


import Alamofire
import UIKit

class WebServiceProxy {
    
    static var shared: WebServiceProxy {
        return WebServiceProxy()
    }
    fileprivate init(){ }
    
    func handelResponseStauts(response: AFDataResponse<Any>, completion: @escaping (ApiResponse?) -> Void)  {
        DispatchQueue.main.async {
             Proxy.shared.hideActivityIndicator()
        }
    //  URLCache.shared.removeAllCachedResponses()
        if response.data != nil && response.error == nil {
            debugPrint("RESPONSE",response.value!)
            debugPrint("JSON-RESPONSE", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
            let dict  = response.value as? [String:AnyObject]
            if let dateCheck = dict!["dateCheck"] as? String {
                if !Proxy.shared.expiryDateCheckMethod(expiryDate: dateCheck) {
                    return
                }
            }
            if response.response?.statusCode == 200 {
                let res : ApiResponse?
                res = ApiResponse(jsonData: response.data!, data: dict as NSDictionary?, message: dict!["message"] as? String ?? "success")
                completion(res!)
            } else if response.response?.statusCode == 400 {
                Proxy.shared.displayStatusCodeAlert(dict!["message"] as? String ?? "error")
            } else {
                self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
            }
        } else {
            self.statusHandler(response.response, data: response.data, error: response.error as NSError?)
        }
    }

    // MARK: - Server Sent Status Code Handler
    func statusHandler(_ response:HTTPURLResponse?, data:Data?, error:NSError?) {
        if let code = response?.statusCode {
            if code == 401 ||  code == 403{
                UserDefaults.standard.set("", forKey: "access-token")
                UserDefaults.standard.synchronize()
                RootControllerProxy.shared.rootWithoutDrawer(LoginVC.className)
            }else{
                let myHTMLString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                debugPrint(myHTMLString!)
                Proxy.shared.displayStatusCodeAlert(myHTMLString! as String)
            }
        } else {
            if data != nil{
            let myHTMLString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                debugPrint(myHTMLString!)
                Proxy.shared.displayStatusCodeAlert(myHTMLString! as String)
            }
        }
    }
}


