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
    var req: SearchWord?
}

struct CommunitySearchData: Decodable {
    var id: Int?
    var pin: Int?
    var title: String?
    var registerDate: String?
    var confirm: Int?
}

struct SearchWord: Decodable {
    var searchWord: String?
}
