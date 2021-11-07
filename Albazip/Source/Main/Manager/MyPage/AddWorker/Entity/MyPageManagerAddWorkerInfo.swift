//
//  MyPageManagerAddWorkerInfo.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/07.
//

import Foundation
class MyPageManagerAddWorkerInfo{
    static let shared = MyPageManagerAddWorkerInfo()
    var rank: String?
    var title: String?
    var startTime: String?
    var endTime: String?
    var workTime: String?
    var workDays: [String]?
    var breakTime: String?
    var salary: String?
    var salaryType: String?
    private init() { }
}
