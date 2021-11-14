//
//  MyPageDetailClearWorkDayResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

struct MyPageDetailClearWorkDayResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageDetailClearWorkDayData?
}

struct MyPageDetailClearWorkDayData: Decodable {
    var nonCompleteTaskData: [MyPageDetailClearWorkDayNonCompleteTaskData]?
    var completeTaskData: [MyPageDetailClearWorkDayCompleteTaskData]?
}
struct MyPageDetailClearWorkDayNonCompleteTaskData: Decodable{
    var title: String?
    var content: String?
}
struct MyPageDetailClearWorkDayCompleteTaskData: Decodable{
    var title: String?
    var content: String?
    var complete_date: String?
}
