//
//  MyPageDetailCommuteRecordResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
struct MyPageDetailCommuteRecordResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageDetailCommuteRecordData?
}

struct MyPageDetailCommuteRecordData: Decodable {
    var year: String?
    var month: String?
    var commuteData: [MyPageDetailCommuteRecordCommuteData]?
}
struct MyPageDetailCommuteRecordCommuteData: Decodable{
    var year: String?
    var month: String?
    var day: String?
    var start_time: String?
    var end_time: String?
    var real_start_time: String?
    var real_end_time: String?
    var start_late: Int?
    var end_late: Int?
}

