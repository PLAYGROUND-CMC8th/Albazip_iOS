//
//  RegisterResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

struct RegisterResponse: Decodable {
    var message: String
    var data: RegisterResponseData?
}

struct RegisterResponseData: Decodable {
    var token: String
}
