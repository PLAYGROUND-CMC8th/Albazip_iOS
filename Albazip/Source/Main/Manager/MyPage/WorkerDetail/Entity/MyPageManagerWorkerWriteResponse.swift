//
//  MyPageManagerWorkerWriteResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

struct MyPageManagerWorkerWriteResponse: Decodable {
    var code: String?
    var message: String?
    var data: [MyPageManagerWorkerWriteData]?
}

struct MyPageManagerWorkerWriteData: Decodable {
    var id: Int?
    var writerTitle: String?
    var title: String?
    var content: String?
    var registerDate: String?
    var writerName: String?
}
