//
//  SettingEditBasicInfoRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/16.
//

import Foundation
struct SettingEditBasicInfoRequest: Encodable {
    var firstName: String?
    var lastName: String?
    var birthyear: String?
    var gender: String?
}
