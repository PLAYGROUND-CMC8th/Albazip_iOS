//
//  SignInManagerInfo.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

import Foundation
class SignInManagerInfo{
    static let shared = SignInManagerInfo()
    var name: String?
    var type: String?
    var address: String?
    var ownerName: String?
    var registerNumber: String?
    private init() { }
}
