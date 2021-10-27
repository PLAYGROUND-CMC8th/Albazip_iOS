//
//  SignInResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

struct SignInResponse: Decodable {
    var message: String
    var data: SignInResponseData?
}

struct SignInResponseData: Decodable {
    var token: Int
}
