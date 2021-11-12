//
//  MyPageManagerWorkerDetailProfileResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

struct MyPageManagerWorkerDetailProfileResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageManagerWorkerDetailProfileData?
}

struct MyPageManagerWorkerDetailProfileData: Decodable {
    var rank: String?
    var title: String?
    var imagePath: String?
    var firstName: String?
}
