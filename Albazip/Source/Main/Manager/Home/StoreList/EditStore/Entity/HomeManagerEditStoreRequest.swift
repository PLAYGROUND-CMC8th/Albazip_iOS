//
//  HomeManagerEditStoreRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

struct HomeManagerEditStoreRequest: Encodable {
    var name: String
    var type: String
    var address: String
    var openSchedule: [OpenSchedule]
    var holiday: [String]
    var payday: String
}
