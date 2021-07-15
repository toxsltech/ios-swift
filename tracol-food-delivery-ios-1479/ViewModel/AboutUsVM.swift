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
import WebKit

class AboutUsVM: NSObject {
    //MARK:- Variables
    var type = Int()
    var descriptionVal = String()
    var isComeFrom = ""
    //MARK:- Hit page api
    func hitPagesApi(_ type : Int, completion:@escaping() -> Void){
        let result = GetFeaturesService.pagesList(type).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if let detailDict = data["detail"] as? NSDictionary{
                        self.descriptionVal =  detailDict["description"] as? String ?? ""
                        completion()
                    }
                }
                
            }
        }
    }
}
extension AboutUsVC: WKNavigationDelegate,WKUIDelegate {
    //MARK:- Set initial value
    func setInitialData(){
        lblHeader.text! = title == "Terms" ? PagesConstant.terms.termsConditonType : title!
        webView.sizeToFit()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        switch title {
        case PagesConstant.privacyPolicy.termsConditonType:
            objAboutUsVM.type = PagesConstant.privacyPolicy.rawValue
        case PagesConstant.aboutUs.termsConditonType:
            objAboutUsVM.type = PagesConstant.aboutUs.rawValue
        case PagesConstant.terms.termsConditonType:
            objAboutUsVM.type = PagesConstant.terms.rawValue
        default:
            break
        }
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
        objAboutUsVM.hitPagesApi(objAboutUsVM.type){
            self.webView.loadHTMLStringWithMagic(content: self.objAboutUsVM.descriptionVal, baseURL: nil)
            self.webView.isOpaque = false
        }
    }
}
