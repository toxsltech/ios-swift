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


extension UIViewController {


    //MARK:- Push/POP methods
    func moveToNext(_ identifier: String,titleStr: String = "",animation: Bool = true) {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        controller.title = titleStr
        self.navigationController?.pushViewController(controller, animated: animation)
    }
    func popToBack(_ animate:Bool = true) {
        self.navigationController?.popViewController(animated: animate)
    }
    //MARK:- Present/Dismiss methods
    func presentWithTitle(_ identifier: String, titleStr: String = "") {

        let controller = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        controller.title = titleStr
        self.present(controller, animated: true)
    }

    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    func noDataFound(_ tableView : UITableView,msg:String="No Data Found") {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x:0, y:0, width:tableView.bounds.size.width,height: tableView.bounds.size.height))
        noDataLabel.text = msg
        noDataLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        noDataLabel.font = UIFont(name: FontName.medium, size: 17)
        noDataLabel.textAlignment = NSTextAlignment.center
        tableView.backgroundView = noDataLabel
    }
    func noDataFound(_ collectionView : UICollectionView) {
          let noDataLabel: UILabel = UILabel(frame: CGRect(x:0, y:0, width:collectionView.bounds.size.width,height: collectionView.bounds.size.height))
          noDataLabel.text = "No Data Found"
          noDataLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
          noDataLabel.font = UIFont(name: FontName.medium, size: 17)
          noDataLabel.textAlignment = NSTextAlignment.center
          collectionView.backgroundView = noDataLabel
      }

    func showAlertWithMultiActions(_ title: String, msg: String, actions: [String], isCancelAction: Bool, completion:@escaping(_ title: String) -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        if isCancelAction {
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (actionCancel) in
                self.dismiss(animated: true, completion: nil)
            }))
        }

        for action in actions {
            alert.addAction(UIAlertAction(title: action, style: .default, handler: { (alert) in
                completion(action)
            })
            )}

        self.present(alert, animated: true, completion: nil)
    }
}


extension Notification.Name {
    static let topMenu = NSNotification.Name("topmenu")
}


extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension UINavigationController {
    
    func backToViewController(viewController: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
            locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
