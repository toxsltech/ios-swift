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
//

import UIKit
import Foundation
import AVFoundation

protocol CustomGalleryProtocol {
    func didGetSelectedImage( image: UIImage,path:String)
}

class CustomGalleryClass: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- variable Decleration
    var imagePicker = UIImagePickerController()
    var currentController = UIViewController()
    var localPath = String()

    //MARK: - Delegate
    var delegate: CustomGalleryProtocol?

    //Mark:- Choose Image Method
    func customActionSheet(controller: UIViewController) {
        
        currentController = controller
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            self.callCamera()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                     DispatchQueue.main.async {
                    self.callCamera()
                    }
                } else {
                    self.presentCameraSettings()
                }
            })
        }
    }
    
    func presentCameraSettings() {
        
        let settingAlert = UIAlertController(title: TitleMessage.permit, message: TitleMessage.cameraPermit, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: TitleMessage.ok, style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        
        let openSetting = UIAlertAction(title:TitleMessage.settings, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        UIApplication.shared.keyWindow?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    }
    
    func callCamera()  {
        
        let myActionSheet = UIAlertController()
        let galleryAction = UIAlertAction(title: TitleMessage.choosePhoto, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
         //   DispatchQueue.main.async {
                self.openGallary()
          //  }
            
        })
        let cameraAction = UIAlertAction(title: TitleMessage.takePhoto, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
          //   DispatchQueue.main.async {
            self.openCamera()
          //  }
        })
        
        let cancelAction = UIAlertAction(title: TitleMessage.cancel, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        myActionSheet.addAction(galleryAction)
        myActionSheet.addAction(cameraAction)
        myActionSheet.addAction(cancelAction)
        DispatchQueue.main.async {
        self.currentController.present(myActionSheet, animated: true, completion: nil)
        }
    }
    //MARK:- Open Image Camera
    func openCamera() {
     //   DispatchQueue.main.async {
          
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
               
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = true
                self.currentController.present(self.imagePicker, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: TitleMessage.camera, message: TitleMessage.cameraNotSupport, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: TitleMessage.ok, style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                 DispatchQueue.main.async {
                self.currentController.present(alert, animated: true, completion: nil)
                }
            }
//}
    }
    
    //MARK:- Open Image Gallery
    func openGallary() {
        DispatchQueue.main.async {

            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.currentController.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          DispatchQueue.main.async {
            let image: UIImage = info[.editedImage] as! UIImage
            if #available(iOS 11.0, *) {
                               
                               if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
                                   
                                   let imgName = imgUrl.lastPathComponent
                                   
                                   let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                                   
                                   self.localPath = (documentDirectory?.appending(imgName))!
                                self.delegate?.didGetSelectedImage(image: image, path: self.localPath)
                                   
                                   
                               }else {
                                self.localPath = TitleMessage.imageUpload
                                self.delegate?.didGetSelectedImage(image: image, path: self.localPath)
                                
                }
                
            } else {
                self.localPath = TitleMessage.imageUpload
                self.delegate?.didGetSelectedImage(image: image, path: self.localPath)
                
            }
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.currentController.dismiss(animated: true, completion: nil)
    }
}
