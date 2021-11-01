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
    var token: Token
    var userInfo: UserInfo?
    var shopInfo : ShopInfo?
    var positionInfo: PositionInfo?
    var taskInfo : TaskInfo?
    var boardInfo : BoardInfo?
    var scheduleInfo: ScheduleInfo?
}
struct Token: Decodable{
    var token : String
}
struct UserInfo: Decodable{
    var id: Int
    var phone: String
    var pwd: String
    var salt: String
    var last_name: String
    var first_name: String
    var birthyear: String
    var gender: Bool
    var image_path: String?
    var last_position: String?
    var refresh_token: String?
    var latest_access_date: String
    var register_date: String
    var update_date: String
}

struct ShopInfo: Decodable {
    var id: Int
    var name: String
    var type: String
    var address: String
    var owner_name: String
    var register_number: String
    var business_time: String
    var holiday: String?
    var payday: String
    var register_date: String
    var update_date: String
}

struct PositionInfo: Decodable {
    var id: Int
    var shop_id: Int
    var code: String
    var title: String
    var rank: String
    var salary: String
    var salary_type: Int
    var work_day: String
    var start_time: String
    var end_time: String
    var work_time: String
    var break_time: String?
    var register_date: String
    var update_date: String
}

struct TaskInfo: Decodable {
    
}

struct BoardInfo: Decodable {
    
}

struct ScheduleInfo: Decodable {
    
}
