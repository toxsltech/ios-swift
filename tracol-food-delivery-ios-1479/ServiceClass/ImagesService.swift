
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

enum ImagesService {
    case updateProfile(UpDateProfileRequest)
    
    var path: String {
        switch self {
        case .updateProfile: return  "user/update-profile"
        }
    }
    var sampleData: Data { Data() }
    
    var task: DataRequest {
        DispatchQueue.main.async {
            Proxy.shared.showActivityIndicator()
        }
        var parameters = [String : String]()
        var parameterImage = [String : UIImage]()
        switch self {
        case let .updateProfile(request):
            parameters = ["User[first_name]" : request.firstName!,
                          "User[last_name]": request.lastName!,
                          "User[email] ": request.email!,
                         // "User[city]": request.city!,
                          //"User[country]": request.country!,
                          "User[contact_no]": request.mobileNo!,
                          "User[longitude]": objUserModel.longitude,
                          "User[latitude]":objUserModel.latitude]
            if request.profilePic != #imageLiteral(resourceName: "ic_userdummy") {
                parameterImage = ["User[profile_file]": request.profilePic!]
            }
        }
        debugPrint("parameters", parameters)
        debugPrint("image parameters", parameterImage)
        debugPrint("baseURL" , "\(baseURL)\(path)")
        debugPrint("accessToken" ,Proxy.shared.accessNil())
        
        return   AF.upload(multipartFormData: { multipartFormData in
            for (key, val) in parameters {
                multipartFormData.append(val.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
            for (key, val) in parameterImage {
                let timeStamp = Date().timeIntervalSince1970 * 1000
                let fileName = "image\(timeStamp).png"
                guard let imageData = val.jpegData(compressionQuality: 0.3) else {  return
                }
                multipartFormData.append(imageData, withName: key, fileName: fileName , mimeType: "image/png")
            }
        },
                           to: "\(baseURL)\(path)", method: methodPost , headers: headers)
    }
} 
