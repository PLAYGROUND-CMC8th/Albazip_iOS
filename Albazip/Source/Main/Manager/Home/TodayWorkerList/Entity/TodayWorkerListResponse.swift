//
//  TodayWorkerListResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

struct TodayWorkerListResponse: Decodable {
    var code: String?
    var message: String?
    var data: [TodayWorkerListData]?
}

struct TodayWorkerListData : Decodable{
    var workerId: Int?
    var workerTitle: String?
    var workerName: String?
    var workerImage: String?
}
