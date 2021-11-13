//
//  RegisterManagerResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

struct RegisterManagerResponse: Decodable {
    var message: String
    var code: String
    var data: RegisterManagerData?
}
struct RegisterManagerData :Decodable{
    var token: String
}
