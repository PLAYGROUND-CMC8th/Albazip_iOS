//
//  HomeWorkerResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

struct HomeWorkerResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeWorkerData?
}

struct HomeWorkerData: Decodable {
    var todayInfo: HomeWorkerTodayInfo?
    var shopInfo: HomeWorkerShopInfo?
    var scheduleInfo: HomeWorkerScheduleInfo?
    var taskInfo: HomeWorkerTaskInfo?
    var boardInfo: [HomeWorkerBoardInfo]?
}
struct HomeWorkerTodayInfo: Decodable {
    var month: Int?
    var date: Int?
    var day: String?
}
struct HomeWorkerShopInfo: Decodable {
    var status: Int?
    var shopName: String?
}
struct HomeWorkerScheduleInfo: Decodable {
    var positionTitle: String?
    var startTime: String?
    var endTime: String?
    var realStartTime: String?
    var realEndTime: String?
    var remainTime: String?
}
struct HomeWorkerTaskInfo: Decodable{
    var coTask: HomeWorkerCoTask?
    var perTask: HomeWorkerPerTask?
}
struct HomeWorkerBoardInfo: Decodable{
    var status: Int?
    var id: Int?
    var title: String?
}
struct HomeWorkerCoTask: Decodable{
    var completeCount: Int?
    var totalCount: Int?
}
struct HomeWorkerPerTask: Decodable{
    var completeCount: Int?
    var totalCount: Int?
}
