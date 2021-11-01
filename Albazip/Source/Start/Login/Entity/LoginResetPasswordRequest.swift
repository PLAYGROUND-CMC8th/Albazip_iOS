//
//  LoginResetPasswordRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/01.
//

struct LoginResetPasswordRequest: Encodable {
    var phone: String
    var pwd: String
}
