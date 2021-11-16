//
//  SettingMyInfoResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/16.
//

struct SettingMyInfoResponse: Decodable {
    var code: String?
    var message: String?
    var data: SettingMyInfoData?
}

struct SettingMyInfoData: Decodable {
    var firstName: String?
    var lastName: String?
    var birthyear: String?
    var gender: Int?
    var phone: String?
}
