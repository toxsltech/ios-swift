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

class PaymentWebViewVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var paymentWebVw: WKWebView!
    
    //MARK:- Variables
    var objPaymentWebViewVM = PaymentWebViewVM()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        objPaymentWebViewVM.pageLoad = false
        let url = URL(string: self.title!)!
        paymentWebVw.navigationDelegate = self
        Proxy.shared.showActivityIndicator()
        paymentWebVw.uiDelegate = self
        paymentWebVw.allowsBackForwardNavigationGestures = true
        paymentWebVw.load(URLRequest(url: url))
    }
    
    //MARK:- IBActions
    @IBAction func actionBack(_ sender: Any) {
        RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)
    }
}

extension PaymentWebViewVC: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if self.objPaymentWebViewVM.pageLoad == true{
          //  self.objPaymentWebViewVM.addConnectAcountApi(){
                
            RootControllerProxy.shared.rootWithDrawer(KRTabBarController.className)
           // }
        }
        Proxy.shared.hideActivityIndicator()
    }
    
    func webViewDidClose(_ webView: WKWebView) {
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            let stringResult = url.absoluteString.contains("user/profile")
            if stringResult == true{
                self.objPaymentWebViewVM.responseUrl = url.absoluteString
                self.objPaymentWebViewVM.pageLoad = true
            }
        }
        decisionHandler(.allow)
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
