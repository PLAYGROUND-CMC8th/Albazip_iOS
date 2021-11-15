//
//  MyPageDetailClearWorkMonthResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
struct MyPageDetailClearWorkMonthResponse: Decodable {
    var code: String?
    var message: String?
    var data: [MyPageDetailClearWorkMonthData]?
}

struct MyPageDetailClearWorkMonthData: Decodable {
    var month: String?
    var day: String?
    var week_day: String?
    var totalCount: Int?
    var completeCount: Int?
}
