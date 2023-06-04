//
//  Firebase.swift
//  Albazip
//
//  Created by 김수빈 on 2023/06/04.
//

import Foundation

import FirebaseAnalytics

struct Firebase {
    enum Log: String {
        case signupAgreement = "signupAgreement"
        case signupPhoneNumber = "signupPhoneNumber"
        case signupPassword = "signupPassword"
        case signupInfo = "signupInfo"
        case signupSelectPosition = "signupSelectPosition"
        case signupSearchStoreBefore = "signupSearchStoreBefore"
        case signupSearchStoreAfter = "signupSearchStoreAfter"
        case signupStoreInfo = "signupStoreInfo"
        case signupManagerInfo = "signupManagerInfo"
        case signupMoreInfo = "signupMoreInfo"
        case signupOperatingTime = "signupOperatingTime"
        case signupManagerOnboarding = "signupManagerOnboarding"
        case signupCode = "signupCode"
        case signupEmployeeOnboarding = "signupEmployeeOnboarding"
        
        func event(parameters: [String: Any]? = nil) {
            Analytics.logEvent(rawValue, parameters: parameters)
        }
    }
}
