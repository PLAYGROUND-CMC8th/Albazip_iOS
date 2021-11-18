//
//  MyPageManagerEditWorkerRepuest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//



struct MyPageManagerEditWorkerData2: Encodable {
    var rank: String
    var title: String
    var startTime: String
    var endTime: String
    var workDay: [String]
    var breakTime: String
    var salary: String
    var salaryType: Int
    var taskList: [EditTaskLists2]
}
struct EditTaskLists2: Encodable{
    var title: String
    var content: String
    var id: Int
}
