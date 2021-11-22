//
//  HomeWorkerTodayWorkResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

struct HomeWorkerTodayWorkResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeWorkerTodayWorkData?
}
struct HomeWorkerTodayWorkData: Decodable {
    var coTask: HomeWorkerCoTaskList?
    var perTask: HomeWorkerPerTaskList?
}

//공동업무
struct HomeWorkerCoTaskList: Decodable {
    var nonComCoTask: [HomeWorkerNonComCoTask]?
    var comWorker: HomeWorkerComWorker?
    var comCoTask: [HomeWorkerComCoTask]?
}
struct HomeWorkerNonComCoTask: Decodable {
    var taskId: Int?
    var takTitle: String?
    var taskContent: String?
    var writerTitle: String?
    var writerName: String?
    var registerDate: String?
}

struct HomeWorkerComWorker: Decodable {
    var comWorkerNum: Int?
    var comWorker: HomeWorkerComWorkerList? // 에라모르겠다!
}
struct HomeWorkerComWorkerList :Decodable{
    
}
struct HomeWorkerComCoTask: Decodable {
    var taskId: Int?
    var takTitle: String?
    var completeTime: String?
}

//개인 업무
struct HomeWorkerPerTaskList: Decodable {
    var positionTitle: String?
    var nonComPerTask: [HomeWorkerNonComCoTask]?
    var compPerTask: [HomeWorkerComCoTask]?
}




//사용하지말자 위에꺼 재사용하기!
struct HomeWorkerNonComPerTaskList: Decodable {
    var taskId: Int?
    var takTitle: String?
    var taskContent: String?
    var writerTitle: String?
    var writerName: String?
    var registerDate: String?
}
