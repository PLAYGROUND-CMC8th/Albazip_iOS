//
//  CommunityManagerNoticeDetailResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
struct CommunityManagerNoticeDetailResponse: Decodable {
    var code: String?
    var message: String?
    var data: CommunityManagerNoticeDetailData?
}

struct CommunityManagerNoticeDetailData: Decodable {
    var writerInfo: CommunityManagerNoticeWriterInfo?
    var boardInfo: CommunityManagerNoticeBoardInfo?
    var confirmInfo: CommunityManagerNoticeConfirmInfo?
}

struct CommunityManagerNoticeWriterInfo: Decodable {
    var title: String?
    var name: String?
    var image: String?
}
struct CommunityManagerNoticeBoardInfo: Decodable {
    var title: String?
    var content: String?
    var registerDate: String?
    var image: [CommunityManagerNoticeImage]?
}
struct CommunityManagerNoticeConfirmInfo: Decodable {
    var count: Int?
    //"confirmer": []
}
struct CommunityManagerNoticeImage: Decodable {
    var id: Int?
    var image_path: String?
}
