//
//  RegisterWorkerResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/31.
//

struct RegisterWorkerResponse: Decodable {
    var message: String
    var code: String
    var data: RegisterWorkerData?
}
struct RegisterWorkerData :Decodable{
    var token: String
}
