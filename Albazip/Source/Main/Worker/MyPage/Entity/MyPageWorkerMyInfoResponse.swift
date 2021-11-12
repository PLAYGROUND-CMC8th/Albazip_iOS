//
//  MyPageWorkerMyInfoResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

struct MyPageWorkerMyInfoResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageWorkerMyInfoData?
}

struct MyPageWorkerMyInfoData: Decodable {
    var userInfo: MyPageWorkerMyInfoUserInfo
    var workInfo: MyPageWorkerMyInfoWorkInfo
    var joinDate: String?
}

struct MyPageWorkerMyInfoUserInfo: Decodable{
    var phone: String?
    var birthyear: String?
    var gender: Int?
}

struct MyPageWorkerMyInfoWorkInfo: Decodable{
    var lateCount: Int?
    var coTaskCount: Int?
    var completeTaskCount: Int?
    var totalTaskCount: Int?
}

