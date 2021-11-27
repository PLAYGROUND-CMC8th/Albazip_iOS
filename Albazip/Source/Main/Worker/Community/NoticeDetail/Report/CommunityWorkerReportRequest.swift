//
//  CommunityWorkerReportRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation
struct CommunityWorkerReportRequest: Encodable {
    var noticeId: Int
    var reportReason: String
}
