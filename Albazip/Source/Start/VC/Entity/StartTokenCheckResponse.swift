//
//  StartTokenCheckResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
struct StartTokenCheckResponse: Decodable {
    var code: String?
    var message: String?
    var status: Int?
}
