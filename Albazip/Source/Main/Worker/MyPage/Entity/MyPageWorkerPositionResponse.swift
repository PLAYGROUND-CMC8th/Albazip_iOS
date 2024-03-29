//
//  MyPageWorkerPositionResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

struct MyPageWorkerPositionResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageWorkerPositionData?
}

struct MyPageWorkerPositionData: Decodable {
    var breakTime: String?
    var workDay: String?
    var salaryType: Int?
    var salary: String?
    var workSchedule: [WorkSchedule]?
}
