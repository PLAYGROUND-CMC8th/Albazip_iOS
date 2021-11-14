//
//  MyPageDetailPublicWorkResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
struct MyPageDetailPublicWorkResponse: Decodable {
    var code: String?
    var message: String?
    var data: [MyPageDetailPublicWorkData]?
}

struct MyPageDetailPublicWorkData: Decodable {
    var title: String?
    var content: String?
    var year: String?
    var month: String?
    var date: String?
    var complete_date: String?
}
