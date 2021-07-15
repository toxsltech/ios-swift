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
import CoreLocation
import NVActivityIndicatorView
//import MapKit
import SDWebImage
//import SwiftyDrop
import Alamofire
import AVKit


let KAppDelegate = UIApplication.shared.delegate as! AppDelegate

class Proxy {
    static var shared: Proxy {
        return Proxy()
    }
    private init(){}
    
    func accessNil() -> String {
        if let accessToken = UserDefaults.standard.object(forKey: "access-token") as? String {
            return accessToken
        } else {
            return ""
        }
    }
    
    func getLatitude() -> String {
        if UserDefaults.standard.object(forKey: "lat") != nil {
            let currentLat =  UserDefaults.standard.object(forKey: "lat") as! String
            return currentLat
        }
        return ""
    }
    
    func getLongitude() -> String {
        if UserDefaults.standard.object(forKey: "long") != nil {
            let currentLong =  UserDefaults.standard.object(forKey: "long") as! String
            return currentLong
        }
        return ""
    }
    
    func getCurrentAddress() -> String {
        if UserDefaults.standard.object(forKey: "address") != nil {
            let currentLong =  UserDefaults.standard.object(forKey: "address") as! String
            return currentLong
        }
        return ""
    }
    func getRememberVal() -> (String,String) {
        var email = ""
        var password = ""
        if let emailVal = UserDefaults.standard.object(forKey: "email") as? String {
            email = emailVal
        }
        if let passwordVal = UserDefaults.standard.object(forKey: "password") as? String {
            password = passwordVal
        }
        return (email,password)
    }
    
    func deviceToken() -> String {
        var deviceTokken =  ""
        if UserDefaults.standard.object(forKey: "device_token") == nil {
            deviceTokken = "00000000055"
        } else {
            deviceTokken = UserDefaults.standard.object(forKey: "device_token")! as! String
        }
        return deviceTokken
    }
    
    func registerNib(_ tblView: UITableView, identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: identifierCell)
    }
    func registerCollViewNib(_ collView: UICollectionView, identifierCell:String){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        collView.register(nib, forCellWithReuseIdentifier: identifierCell)
    }
    func statusBarColor(scrrenColor: String){
        UIApplication.shared.statusBarStyle = scrrenColor == "Black" ? .lightContent : .default
    }
    
    func clearChache(){
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
    
    func getStringValue(_ value: Any) -> String{
        var finalVal = ""
        if let  idVal   = value as? Int{
            finalVal = "\(idVal)"
        } else if let  idVal   = value as? Double{
            finalVal = "\(idVal)"
        } else if let  idVal   = value as? Float{
            finalVal = "\(idVal)"
        } else  if let idVal = value as? String{
            finalVal = idVal
        }
        return finalVal
    }
    
    func getIntegerValue(_ value: Any) -> Int{
        
        var finalVal = Int()
        finalVal = 0
        if let  idVal = value as? Int{
            finalVal = idVal
        } else if let  idVal   = value as? Double{
            finalVal = Int(idVal)
        } else  if let idVal = value as? String{
            if idVal != ""{
            finalVal = Int(Double(idVal)!)
            }else{
                finalVal = 0
            }
        }
        return finalVal
    }
    
    //MARK: - HANDLE ACTIVITY
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityData = ActivityData(size: CGSize(width: 50, height: 50), type: .lineScale, color: .white)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData,nil)
        }
    }
    func hideActivityIndicator()  {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            
        }
    }
    
    //MARK:- Check Valid Email Method
    func isValidEmail(_ testStr:String) -> Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return (testStr.range(of: emailRegEx, options:.regularExpression) != nil)
    }
    
    //MARK:- Check Valid Full Name
    func isValidName(_ testStr:String) -> Bool {
        //testStr.count > 0,
        guard testStr.count < 18 else { return false }
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    //MARK:- Display Toast
    func displayStatusCodeAlert(_ userMessage: String) {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                let window:UIWindow =  sd.window!
                window.rootViewController?.view.makeToast(message: userMessage,
                                                          duration: TimeInterval(2.0),
                                                          position: .bottom,
                                                          title: "",
                                                          backgroundColor: .black,
                                                          titleColor: .white,
                                                          messageColor: .white,
                                                          font: nil)
                window.makeKeyAndVisible()
            }
        } else {
            KAppDelegate.window?.rootViewController?.view.makeToast(message: userMessage,
                                                                    duration: TimeInterval(2.0),
                                                                    position: .bottom,
                                                                    title: "",
                                                                    backgroundColor: .black,
                                                                    titleColor: .white,
                                                                    messageColor: .white,
                                                                    font: nil)
            KAppDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func expiryDateCheckMethod(expiryDate: String)->Bool  {
        let dateInFormat = DateFormatter()
        dateInFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateInFormat.dateFormat = "yyyy-MM-dd"
        let expiryDate = dateInFormat.date(from: expiryDate)
        if Date().compare(expiryDate!) == .orderedDescending {
            //  Proxy.shared.displayDateCheckAlert()
            return false
        }
        return true
        
    }
    func dateConvertDay(date : String,dateFormat:String,getFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let inputtime  = formatter.date(from: date)
        formatter.dateFormat = getFormat
        let outputTime = formatter.string(from: inputtime!)
        return outputTime
        
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func displayDateCheckAlert(){
        let alertController = UIAlertController(title: TitleMessage.demoExpired, message:  TitleMessage.contactWithTeam, preferredStyle: .alert)
        let cancelBtnAction = UIAlertAction(title: TitleMessage.ok, style: .destructive) { (action) in}
        alertController.addAction(cancelBtnAction)
        KAppDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func openSettingApp() {
        let settingAlert = UIAlertController(title: TitleMessage.connectionProblem, message: TitleMessage.internetConnection, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: TitleMessage.cancel, style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title:TitleMessage.settings, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    //Proxy.shared.displayStatusCodeAlert(AlertMessage.pleaseReviewYourNetworkSettings)
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    }
    
    func createAttributedString(fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor) -> NSMutableAttributedString
    {
        let range = (fullString as NSString).range(of: subString)
        let attributedString = NSMutableAttributedString(string:fullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fullStringColor, range: NSRange(location: 0, length: fullString.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: subStringColor, range: range)
        return attributedString
    }
    
    func serializationString(arr : NSMutableArray) -> String {
        var feedbackResponse = NSString()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
            feedbackResponse = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        }catch let error as NSError{
            Proxy.shared.displayStatusCodeAlert(error.localizedDescription)
        }
        return feedbackResponse as String
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
}
