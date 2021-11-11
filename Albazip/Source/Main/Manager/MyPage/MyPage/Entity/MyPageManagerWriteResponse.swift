//
//  MyPageManagerWriteResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

struct MyPageManagerWriteResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageManagerWriteData?
}

struct MyPageManagerWriteData: Decodable {
    var postInfo: [MyPageManagerWritePostInfo]
    var noticeInfo: [MyPageManagerWriteNoticeInfo]
}

struct MyPageManagerWritePostInfo: Decodable{
    var id: Int?
    var writerJob: String?
    var writerName: String?
    var title: String?
    var content: String?
    var commentCount: Int?
    var registerDate: String?
}

struct MyPageManagerWriteNoticeInfo: Decodable{
    var id: Int?
    var pin: Int?
    var title: String?
    var registerDate: String?
}
