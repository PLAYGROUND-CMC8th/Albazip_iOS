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
    var registerNumber: String?
    var token: String?
    var workHour: [WorkHour]?
    var storeHourType = [StoreHourType]()
    var hoilday = Set<String>()
    var allSameHour: Bool = false
    private init() { }
}
struct WorkHour: Encodable {
    var startTime: String?
    var endTime: String?
    var day: String
}
