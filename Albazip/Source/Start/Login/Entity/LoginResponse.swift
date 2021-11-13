//
//  LoginResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

struct LoginResponse: Decodable {
    var message: String
    var code: String
    var data: LoginResponseData?
}

struct LoginResponseData: Decodable {
    var token: Token
    var job: Int
    var userFirstName: String
    
}
struct Token: Decodable{
    var token : String
}

