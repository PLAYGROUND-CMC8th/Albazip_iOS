//
//  MyPageManagerEditWorkerResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

struct MyPageManagerEditWorkerResponse: Decodable {
    var code: String
    var message: String
    var data: MyPageManagerEditWorkerData?
}

struct MyPageManagerEditWorkerData: Decodable {
    var rank: String
    var title: String
    var startTime: String
    var endTime: String
    var workDay: [String]
    var breakTime: String
    var salary: String
    var salaryType: Int
    var taskList: [EditTaskLists]
}
struct EditTaskLists: Decodable{
    var title: String
    var content: String?
    var id: Int
}
