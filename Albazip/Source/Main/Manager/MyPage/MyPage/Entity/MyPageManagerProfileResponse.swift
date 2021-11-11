//
//  MyPageManagerProfileResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

struct MyPageManagerProfileResponse: Decodable {
    var code: String?
    var message: String?
    var data: MyPageManagerProfileData?
}

struct MyPageManagerProfileData: Decodable {
    var shopName: String?
    var jobTitle: String?
    var lastName: String?
    var firstName: String?
    var imagePath: String?
}
