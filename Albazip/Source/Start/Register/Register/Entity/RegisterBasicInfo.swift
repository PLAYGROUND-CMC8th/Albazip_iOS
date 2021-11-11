//
//  RegisterBasicInfo.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

import Foundation
class RegisterBasicInfo{
    static let shared = RegisterBasicInfo()
    var phone: String?
    var pwd: String?
    var lastName: String?
    var firstName: String?
    var birthyear: String?
    var gender: String?
    var token: String?
    private init() { }
}
