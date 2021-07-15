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

import Foundation

final class SettingsManager {
    
    enum Environment: String {
        case local
        case production
    }
    
    private let settingsDictionary: [String: Any]
    
    static let shared = SettingsManager()
    
    init() {
        let filePath = Bundle.main.path(forResource: "AppSettings", ofType: "plist")!
        self.settingsDictionary = NSDictionary(contentsOfFile: filePath) as! [String: Any]
    }
    
    var environment: Environment {
        let string = self.settingsDictionary["environment"] as! String
        return Environment(rawValue: string)!
    }
    var httpPath: String {
        let setting = self.settingsDictionary["http"] as! [String: String]
        return setting[self.environment.rawValue]!
    }
}
