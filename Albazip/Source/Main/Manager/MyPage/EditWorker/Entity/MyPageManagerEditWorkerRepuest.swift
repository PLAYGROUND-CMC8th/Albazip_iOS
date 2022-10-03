//
//  MyPageManagerEditWorkerRepuest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//



struct MyPageManagerEditWorkerRequest: Encodable {
    var rank: String
    var title: String
    var workSchedule: [WorkHour]
    var breakTime: String
    var salary: String
    var salaryType: Int
    var taskLists: [TaskLists]
}
struct EditTaskLists2: Encodable{
    var title: String
    var content: String?
    var id: Int?
}
