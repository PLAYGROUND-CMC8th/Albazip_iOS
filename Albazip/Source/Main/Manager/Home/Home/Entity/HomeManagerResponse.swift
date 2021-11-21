//
//  HomeManagerResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

import Foundation
struct HomeManagerResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeManagerData?
}

struct HomeManagerData: Decodable {
    var todayInfo: HomeManagerTodayInfo?
    var shopInfo: HomeManagerShopInfo?
    var workerInfo : [HomeManagerWorkerInfo]?
    var taskInfo: HomeManagerTaskInfo?
    var boardInfo: [HomeWorkerBoardInfo]?
}
struct HomeManagerTodayInfo: Decodable {
    var month: Int?
    var date: Int?
    var day: String?
}
struct HomeManagerShopInfo: Decodable {
    var status: Int?
    var name: String?
    var startTime: String?
    var endTime: String?
}
struct HomeManagerWorkerInfo: Decodable {
    var title: String?
    var firstName: String?
}
struct HomeManagerTaskInfo: Decodable{
    var coTask: HomeWorkerCoTask?
    var perTask: HomeWorkerPerTask?
}
struct HomeManagerBoardInfo: Decodable{
    var status: Int?
    var id: Int?
    var title: String?
}
struct HomeManagerCoTask: Decodable{
    var completeCount: Int?
    var totalCount: Int?
}
struct HomeManagerPerTask: Decodable{
    var completeCount: Int?
    var totalCount: Int?
}
