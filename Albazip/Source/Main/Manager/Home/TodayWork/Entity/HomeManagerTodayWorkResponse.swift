//
//  HomeManagerTodayWorkResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import Foundation
struct HomeManagerTodayWorkResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeManagerTodayWorkData?
}
struct HomeManagerTodayWorkData: Decodable {
    var coTask: HomeWorkerCoTaskList?
    var perTask: [HomeManagerPerTaskList]?
}

//공동업무 근무자꺼 재사용


//개인 업무 관리자꺼 따로 만들기!
struct HomeManagerPerTaskList: Decodable {
    var workerId: Int?
    var workerTitle: String?
    var workerName: String?
    var totalCount: Int?
    var completeCount: Int?
}
