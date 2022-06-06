//
//  RegisterManagerRequset.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

struct RegisterManagerRequset: Encodable {
    var name: String
    var type: String
    var address: String
    var registerNumber: String
//    var startTime: String
//    var endTime: String
    var workSchedule: [WorkSchedule]
    var breakTime: String
    var holiday: [String]
    var payday: String
}

struct WorkSchedule: Encodable {
    var startTime: String // TODO: ":" 없애서 보내야함
    var endTime: String
    var day: String
}
