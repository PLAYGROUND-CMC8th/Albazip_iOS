//
//  SignInManagerRequset.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

struct SignInManagerRequset: Encodable {
    var name: String
    var type: String
    var address: String
    var ownerName: String
    var registerNumber: String
    var startTime: String
    var endTime: String
    var holiday: [String]
    var payday: String
}
