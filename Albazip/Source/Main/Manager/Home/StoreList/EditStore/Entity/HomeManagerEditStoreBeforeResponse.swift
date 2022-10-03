//
//  HomeManagerEditStoreBeforeResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation

struct HomeManagerEditStoreBeforeResponse: Decodable {
    var code: String?
    var message: String?
    var data: HomeManagerEditStoreBeforeData?
}

struct HomeManagerEditStoreBeforeData: Decodable {
    var name: String?
    var type: String?
    var address: String?
    var openSchedule: [WorkSchedule]
    var breakTime: String?
    var holiday: [String]?
    var payday: String?
}
