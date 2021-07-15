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

import Alamofire
import  UIKit

enum AccountService {
    
    // Account
    case login(LoginRequest)
    case signup(SignUpRequest)
    case logout
    case check
    case forgotPassword(ForgotPasswordRequest)
    case changePassword(ChangePasswordRequest)
    case contactUs(ContactUsRequest)
    case requestOtp(RequestOtp)
    case resendOtp(ResendOtp)
    
    case userNotification(notificationVal: Int)
    case userFav(id: Int)
    case addCard(AddCardRequest)
    case bookingPayment(BookingPaymentRequest)
    case placeOrder(PlaceOrderRequest)
    case productsFav(id: Int)
    case addAddress(AddAddressRequest)
    case payDonation(PayDonationRequest)
    case updateAddress(request: UpdateAddressRequest,id: String)
    case deleteAddress(id: Int)
    
    
    
    var path: String {
        switch self {
        case .changePassword:
            return "user/change-password"
        case .login:
            return "user/login"
        case .signup:
            return "user/signup"
        case .logout:
            return "users/logout"
        case .forgotPassword:
            return "user/forget-password"
        case .contactUs:
            return "user/contact-us"
        case .requestOtp:
            return "user/verify-otp"
        case .resendOtp:
            return "user/resend-otp"
        case .check:
            return "user/check"
        case .userNotification:
            return "user/notification"
        case .userFav( let id):
            return "item/favourite-package?id=\(id)"
        case .addCard:
            return "transactions/add-card"
        case .bookingPayment:
            return "transactions/booking-payment"
        case .placeOrder:
            return "product/place-order"
        case .productsFav( let id):
            return "item/favourite?id=\(id)"
        case .addAddress:
            return "user/add-address"
        case .updateAddress( _, let id):
            return "user/update-address?id=\(id)"
        case .payDonation:
            return "charity/charity-payment"
        case .deleteAddress( let id):
            return "user/delete-address?id=\(id)"
        }
    }
    
    var loading: Bool {
        switch self {
        case .check:
            return  false
        default:
            return  true
        }
    }
    var task: DataRequest {
     
        if loading {
            DispatchQueue.main.async {
                Proxy.shared.showActivityIndicator()
            }
        }
        var parameters = [String : String]()
        
        switch self {
        case .logout:
            parameters = [:]
        case let .forgotPassword(request):
            parameters = ["User[email]": request.email!]
        case let .changePassword(request):
            parameters = ["User[newPassword]": request.newPassword!,
                          "User[confirm_password]": request.confirmPassword!]
        case let .signup(request):
            parameters = ["User[email]": request.email!,
                          "User[password]": request.password!]
        case let .login(request):
            parameters = ["LoginForm[username]": request.email!,
                          "LoginForm[password]": request.password!,
                          "LoginForm[device_token]":DeviceInfo.deviceToken,
                          "LoginForm[device_type]":DeviceInfo.deviceType,
                          "LoginForm[device_name]":DeviceInfo.deviceName]
        case .contactUs(let request):
            parameters = ["Information[full_name]:" : request.name!,
                          "Information[email]": request.email!,
                          "Information[message]": request.descriptions!]
        case .requestOtp(let request):
            parameters = ["User[otp]" : request.code!,
                          "User[email]": request.email!,]
        case .resendOtp(let request):
            parameters = [ "User[email]": request.email!]
        case .check:
            parameters = ["DeviceDetail[device_token]": DeviceInfo.deviceToken,
                          "DeviceDetail[device_type]": DeviceInfo.deviceType,"DeviceDetail[device_name]": DeviceInfo.deviceName]
        case .userNotification(let notificationVal) :
            parameters = ["User[notification_status]": "\(notificationVal)"]
        case let .userFav(selecetdId):
            parameters = ["Item[id]": "\(selecetdId)"]
        case let .addCard(request):
            parameters = ["customer_name": request.cardholderName!,
                          "card_number": request.cardNubmer!,
                          "expiry_date": request.expiryDate!,
                          "cvc": request.cvv!,"is_default": request.isDefault!]
        case let .bookingPayment(request):
            parameters = ["booking_id": request.id!,
                          "price": request.price!]
            
        case let .placeOrder(request):
            parameters = ["itemJson": "\(request.itemArr!)",
                "Order[payment_type]": "1",
                "Order[total_amount]": "\(request.totalAmount!)",
                "Order[address_id]": "\(request.addressId!)"]
            
        case let .productsFav(selecetdId):
            parameters = ["Item[id]": "\(selecetdId)"]
            
        case let .addAddress(request):
            parameters = ["Address[first_name]": objUserModel.firstName,
                          "Address[last_name]": objUserModel.lastName,
                          "Address[primary_address]": request.address!,
                          "Address[city]": request.city!,
                          "Address[zipcode]": request.zipCode!,
                          "Address[contact_no]": request.contactNo!,
                          "Address[secondary_address]": request.landMark!]
       
            
        case let .payDonation(request):
            parameters = ["CharityDetail[amount]": "\(request.amount!)",
            "CharityDetail[charity_id]": "\(request.charityId!)"]
        case let .deleteAddress(selecetdId):
            parameters = ["Item[id]": "\(selecetdId)"]
        case .updateAddress(let request, _):
             parameters = ["Address[first_name]": objUserModel.firstName,
                                     "Address[last_name]": objUserModel.lastName,
                                     "Address[primary_address]": request.address!,
                                     "Address[city]": request.city!,
                                     "Address[zipcode]": request.zipCode!,
                                     "Address[contact_no]": request.contactNo!,
                                     "Address[secondary_address]": request.landMark!]
        }
        debugPrint("parameters", parameters)
        debugPrint("baseURL" , "\(baseURL)\(path)")
        debugPrint("accessToken" ,Proxy.shared.accessNil())
        return AF.request("\(baseURL)\(path)",
            method: methodPost, parameters: parameters,
            encoding: URLEncoding.httpBody,
            headers: headers)
    }
}


