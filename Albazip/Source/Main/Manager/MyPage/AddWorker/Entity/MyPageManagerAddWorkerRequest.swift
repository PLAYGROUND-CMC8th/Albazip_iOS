//
//  MyPageWorkerAddWorkerRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/07.
//

struct MyPageManagerAddWorkerRequest: Encodable {
    var rank: String
    var title: String
    var startTime: String
    var endTime: String
    var workDays: [String]
    var breakTime: String
    var salary: String
    var salaryType: String
    var taskLists: [TaskLists]
}
struct TaskLists: Encodable{
    var title: String
    var content: String
}
