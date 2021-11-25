//
//  CommunityManagerNoticeResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
struct CommunityManagerNoticeResponse: Decodable {
    var code: String?
    var message: String?
    var page: Int?
    var data: [CommunityManagerNoticeData]?
}

struct CommunityManagerNoticeData: Decodable {
    var id: Int?
    var pin: Int?
    var title: String?
    var registerDate: String?
    var confirm: Int?
}

