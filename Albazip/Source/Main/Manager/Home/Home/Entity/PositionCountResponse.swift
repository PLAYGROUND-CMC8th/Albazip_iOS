//
//  PositionCountResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2023/07/01.
//

struct PositionCountResponse: Decodable {
    var code: String?
    var message: String?
    var data: Int
}
