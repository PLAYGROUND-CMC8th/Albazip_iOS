//
//  CommunitySearchResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation
struct CommunitySearchResponse: Decodable {
    var code: String?
    var message: String?
    var page: Int?
    var data: [CommunitySearchData]?
}

struct CommunitySearchData: Decodable {
    var id: Int?
    var pin: Int?
    var title: String?
    var registerDate: String?
    var confirm: Int?
}

