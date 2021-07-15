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

struct SignUpRequest {
    let email: String?
    let password: String?
    let confPassword: String?
    let isAcceptTerms: Bool?
    
}

struct LoginRequest {
    let email: String?
    let password: String?
}

struct RequestOtp {
    let code: String?
    let email : String?
}

struct ResendOtp {
    let email : String?
}

struct UpDateProfileRequest {
    let firstName: String?
    let lastName : String?
    let email : String?
    let mobileNo: String?
    let profilePic: UIImage?
}

struct ContactUsRequest {
    let name: String?
    let email: String?
    let descriptions: String?
}

struct ForgotPasswordRequest {
    let email: String?
}
struct ChangePasswordRequest {
    let newPassword: String?
    let confirmPassword: String?
}
struct AddCardRequest{
    let cardholderName: String?
    let cardNubmer: String?
    let expiryDate: String?
    let cvv: String?
    let isDefault: String?
}
struct PaymentRequest{
    let modelId: String?
    let price: String?
    let description: String?
    let modelType: String?
    let cvv: String?
    
}

struct AppleSignInRequest {
    let email,
    userName,
    userId,
    provider,
    imageUrl:String?
}

struct AddPrayerRequest {
    let title,
    description:String?
}

struct AddFavouriteRequest {
    let id:String?
}

struct BookingPaymentRequest {
    let id: String?
    let price : String?
}

struct PlaceOrderRequest {
    let itemArr: String?
    let addressId: Int?
    let totalAmount: Int?
}

struct UpdateAddressRequest {
    let address: String?
    let city : String?
    let zipCode : String?
    let contactNo : String?
    let landMark : String?
}

struct PayDonationRequest {
    let amount: String?
    let charityId: Int?

}
struct AddAddressRequest {
    let address: String?
    let city : String?
    let zipCode : String?
    let contactNo : String?
    let landMark : String?
}


