//
//  MyPageManagerAddWorkerInfo.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/07.
//

import Foundation
class MyPageManagerAddWorkerInfo{
    static let shared = MyPageManagerAddWorkerInfo()
    var title: String?
    var workTime: String?
    var workSchedule: [WorkHour]?
    var workDayTypes = [Bool]() // true일때만 근무 요일
    var breakTime: String?
    var salary: String?
    var salaryType: String?
    var allSameHour: Bool = false
    private init() { }
}
