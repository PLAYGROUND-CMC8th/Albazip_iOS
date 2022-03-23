//
//  RegisterManagerInfo.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

import Foundation
class RegisterManagerInfo{
    static let shared = RegisterManagerInfo()
    var name: String?
    var type: String?
    var address: String?
    var ownerName: String? //TODO: 수빈
    var registerNumber: String?
    var token: String?
    private init() { }
}
