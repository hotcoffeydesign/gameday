//
//  Constants.swift
//  Speed Shopper
//
//  Created by mac on 11/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let getPushNotification = Notification.Name(
        rawValue: "getPushNotification")
    static let getPushNotificationFromAppKilled = Notification.Name(
        rawValue: "getPushNotificationAppKilled")
    static let getChat = Notification.Name(
        rawValue: "getChat")
}

struct MainClass {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
}

struct GoogleKeys{
    static let googleClientId = "772095072883-jl4tkk6dsls1shdcn1euac7vplsgumg2.apps.googleusercontent.com"
    static let googleKey = "AIzaSyBVMvG74UXiTBwlIEcuyFXA7MlmPoRYve4"
}

struct UseCaseMessage {
    
    
    static let comingsoon = "Comming soon"
    
    struct validate {
        struct Empty {
            static let UserNameValid = "Please enter a UserName"
            static let mobileInvalid = "Please enter valid contact number"
            static let emailtextField = "Please enter email address"
            static let passwordtextField = "Please enter a password"
            static let fnametextField = "Please enter first name"
            static let lnametextField = "Please enter last name"
            static let Code = "please your hashID No."//Jersey
            static let contacttextField = "Please enter contact number"
            static let cnfrmpasswordtextField = "Please confirm your password"
            static let PasswordNotMatched = "Password not Matche"
            static let addresstextField = "Please enter first name"
            static let imageField = "Please select profile image"
            static let oldpasswordtextField = "Please enter old password"
            static let verificationCode = "Please enter 6 digit verification code"
            static let incorrectOTP = "Incorrect OTP!"
            static let pwd1 = "Please enter new password "
            static let address = "Please enter address "
            static let pwd2 = "Please enter confirm password"
            static let sendRequest = "Please select request"
            static let message = "Message can't be blank"
            static let signature = "Please take signature of your customer"
            static let name = "Pleaes enter name"
            static let validContactNumber = "Please enter valid contact numbetr"
        }
        
        struct statusChanged {
            static let online = "Congratulations now you are online"
            static let offline = "Now you are offline"
            static let picked = "You have already picked this job"
            static let driverOffline = "Currently you are offline, you can't take job"
            static let alreadyOnline = "You have already Online"
            static let pickUp = "Pick-Up:"
            static let dropOff = "Drop-Off:"
            static let startUp = "Start-Up:"
        }
        struct Validtext
        {
            static let emailtextfield = "Please enter valid email address"
            static let passwordtextfield = "Password is too short"
            static let PasswordShort = "Password is too short, please enter a password of minimum 6 characters length"
            static let mobileNumber = "Please enter valid mobile Number"
            static let confirmpasswordtextfield = "Password doesn't match"
            static let typeMessage = "Type Message"
            static let scrollDisable = "You have to signature first"
        }
        
        
        struct NotAvailable {
            static let callingNotAvailable = "Calling function is not avilable in your device"
            static let camera = "Camera not avilable in this device"
            static let gallery = "Photo gallery not avilable in this device"
        }
        
        
        struct errors {
            static let zeroResult = "ZERO_RESULTS"
            static let sessionExpired = "Session expired"
            static let noPathError = "No path exist between your locations"
        }
    }
    struct notify {
        static let checkEmailForResetLink = "We've sent you a link to reset your password. Please check your email."
        static let checkEmailForVerifyLink = "We've sent you a link to verify your account. Please check your email."
        static let loginSuccessful = "Login successfully"
        static let SignUpSuccessful = "SignUp successfully"
        static let AllDocsNeeded = "All documents are compulsory. Please upload all documents. Verification process can take upto 3 working days."
        static let AllDocsAlert = "No document found. Please upload all documents."
        static let saveBooking = "Booking successfull"
        static let update = "Update successfully"
        static let changePWd = "Change  password successfully"
    }
    
    
}




struct AppColor {
    
    static let blackColor = "2B2A2A"
    static let blueColor = "104685"
    static let redColor = "d7172f"
    static let bgColor = "f0f2f5"
}

struct UserType {
    //    1=seller/buyer,2=investor,3=agent
    static let business = "business"
    static let consumer = "consumer"
}
/*
 struct UserType {
 static let business = "business"
 static let consumer = "consumer"
 }
 */

struct HeaderKey {
    static let x_api_key = "x-api-key"
    static let valXApiKey = "7!4#8%4&5(1"
    static let token = "token"
    static let guest = "guest"
    static let Child_id = "id"
}

struct ErrorMessage {
    static let parser = "Parser error"
    static let internet = "Internet is not available"
}


struct ImportantTitle {
    static let yes = "Yes"
    static let no = "No"
}

struct SocialType {
    static let fb = "facebook"
    static let google = "google"
}
struct LocalizedContants {
    
    struct App {
        struct Error {
            struct Network{
                static var Parser: String {
                    return "Server not responding!"
                }
                static var Encoding: String {
                    return "Network Error"
                }
            }
        }
    }
    
}


