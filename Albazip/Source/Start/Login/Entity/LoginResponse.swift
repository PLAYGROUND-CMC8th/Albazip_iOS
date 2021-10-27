//
//  LoginResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

struct LoginResponse: Decodable {
    var message: String
    var data: LoginResponseData?
}

struct LoginResponseData: Decodable {
    var userId: Int
    var positionInfo: String?
}
