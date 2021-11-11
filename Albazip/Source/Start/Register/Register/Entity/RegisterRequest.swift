//
//  RegisterRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

struct RegisterRequest: Encodable {
    var phone: String
    var pwd: String
    var lastName: String
    var firstName: String
    var birthyear: String
    var gender: String
}
