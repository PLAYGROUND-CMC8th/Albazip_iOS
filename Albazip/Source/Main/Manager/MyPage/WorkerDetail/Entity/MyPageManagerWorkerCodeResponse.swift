//
//  MyPageManagerWorkerCodeResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

struct MyPageManagerWorkerCodeResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageManagerWorkerCodeData?
}

struct MyPageManagerWorkerCodeData: Decodable {
    var positionInfo: MyPageManagerWorkerPosisitonInfo?
    
}
struct MyPageManagerWorkerPosisitonInfo: Decodable{
    var code: String?
}

