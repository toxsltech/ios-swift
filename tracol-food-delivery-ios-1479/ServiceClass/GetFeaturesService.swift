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

import  UIKit
import Alamofire

enum GetFeaturesService {
    
    case logout
    case favouriteList
    case countryList(page:Int, searchText:String)
    case notificationEnable
    case getratingList
    case getVideos
    case citiesList(countryId: Int, page:Int, searchText:String)
    case packageList
    case pagesList(_ type : Int)
    case cardList
    case cardDelete(id: String)
    case bannerList
    case orderList
    case productList
    case orderDetail(id: String)
    case userSubscriptionPlan(_ id: Int)
    case packageFavouriteList
    case getTrendingVideos
    case getAddressList
    case getCharity
    case getNotificationList
    case userSearchList(searchText:String)
    case defaultAddress(id: Int)
    
    var path: String {
        switch self {
        case .logout:
            return "user/logout"
        case .favouriteList:
            return "item/favourite-list"
        case .notificationEnable:
            return "user/notification"
        case .getratingList:
            return "rating/rating-list"
        case .getVideos:
            return "product/video-list"
        case .citiesList(let countryId, let page , let searchValue):
            return "user/get-city?country_id=\(countryId)&page=\(page)&name=\(searchValue)"
        case .countryList(let page, let searchText):
            return "user/get-country?page=\(page)&name=\(searchText)"
        case .packageList:
            return "product/package-list"
        case .pagesList(let type):
            return "user/get-page?type_id=\(type)"
        case .cardList:
            return "transactions/card-list"
        case .cardDelete(let id):
            return "transactions/card-delete?id=\(id)"
        case .bannerList:
            return "user/get-banner"
        case .orderList:
            return "product/get-order-list"
        case .productList:
            return "product/product-list"
        case .orderDetail(let id):
            return "product/order-detail?id=\(id)"
        case .userSubscriptionPlan(let id):
            return "product/subscription-detail?id=\(id)"
        case .packageFavouriteList:
            return "item/favourite-package-list"
        case .getTrendingVideos:
            return "video/get-trending-video"
        case .getAddressList:
            return "user/get-address"
        case .getCharity:
            return "charity/get-charity"
        case .getNotificationList:
            return "user/notification-list"
        case .userSearchList(let searchText):
            return "user/search?search=\(searchText)"
            case .defaultAddress(let id):
            return "user/default-address?id=\(id)"
        }
    }
    var task: DataRequest {
        DispatchQueue.main.async {
            Proxy.shared.showActivityIndicator()
        }
        debugPrint("baseURL" , "\(baseURL)\(path)")
        debugPrint("accessToken" ,Proxy.shared.accessNil())
        
        return AF.request("\(baseURL)\(path)",
            method: methodGet, parameters: [:],
            encoding: URLEncoding.default,
            headers:headers)
    }
}


