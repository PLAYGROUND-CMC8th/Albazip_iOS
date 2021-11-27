//
//  HomeManagerStoreListResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

struct HomeManagerStoreListResponse: Decodable {
    var code: String?
    var message: String?
    var data: [HomeManagerStoreListData]?
}

struct HomeManagerStoreListData : Decodable{
    var workerId: Int?
    var managerId: Int?
    var shop_name: String?
    var status: Int?
}
