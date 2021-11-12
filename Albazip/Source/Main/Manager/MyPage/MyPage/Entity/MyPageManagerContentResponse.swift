//
//  MyPageManagerContentResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

struct MyPageManagerContentResponse: Decodable {
    var code: String?
    var message: String?
    var data: [MyPageManagerContentData]?
}
struct MyPageManagerContentData: Decodable {
    var positionId: Int?
    var workerId: Int?
    var status: Int?
    var rank: String?
    var imagePath: String?
    var title: String?
    var firstName: String?
}
