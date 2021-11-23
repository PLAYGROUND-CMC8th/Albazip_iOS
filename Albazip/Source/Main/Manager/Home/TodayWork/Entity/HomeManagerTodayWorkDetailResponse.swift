//
//  HomeManagerTodayWorkDetailResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

struct HomeManagerTodayWorkDetailResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeManagerTodayWorkDetailData?
}
struct HomeManagerTodayWorkDetailData: Decodable {
    var positionTitle: String?
    var nonComPerTask: [HomeWorkerNonComCoTask]?
    var compPerTask: [HomeWorkerComCoTask]?
}
