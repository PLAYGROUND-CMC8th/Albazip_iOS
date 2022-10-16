//
//  MyPageManagerWorkerPositionResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

struct MyPageManagerWorkerPositionResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageManagerWorkerPositionData?
}

struct MyPageManagerWorkerPositionData: Decodable {
    var breakTime: String?
    var workDay: String?
    var salaryType: Int?
    var salary: String?
    var workSchedule: [WorkSchedule]?
}
