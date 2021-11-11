//
//  MyPageWorkerWriteResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

struct MyPageWorkerWriteResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageWorkerWriteData?
}

struct MyPageWorkerWriteData: Decodable {
    var postInfo: [MyPageWorkerWritePostInfo]
}

struct MyPageWorkerWritePostInfo: Decodable{
    var id: Int?
    var writerJob: String?
    var writerName: String?
    var title: String?
    var content: String?
    var commentCount: Int?
    var registerDate: String?
}
