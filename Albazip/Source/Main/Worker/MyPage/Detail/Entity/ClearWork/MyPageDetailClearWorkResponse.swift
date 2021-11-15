//
//  MyPageDetailClearWorkResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

struct MyPageDetailClearWorkResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageDetailClearWorkData?
}

struct MyPageDetailClearWorkData: Decodable {
    var taskRate: MyPageDetailClearWorkTaskRate?
    var taskData: [MyPageDetailClearWorkTaskData]?
}
struct MyPageDetailClearWorkTaskRate: Decodable{
    var completeTaskCount: Int?
    var totalTaskCount: Int?
}
struct MyPageDetailClearWorkTaskData: Decodable{
    var year: String?
    var month: String?
    var totalCount: Int?
    var completeCount: Int?
}
