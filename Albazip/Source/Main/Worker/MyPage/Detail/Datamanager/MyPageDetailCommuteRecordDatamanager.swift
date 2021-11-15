//
//  MyPageDetailCommuteRecordDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Alamofire

class MyPageDetailCommuteRecordDatamanager {
    func getMyPageDetailCommuteRecord(vc: MyPageDetailCommuteRecordVC, year: Int, month: Int) {
        let url = "\(Constant.BASE_URL)/mypage/myinfo/commuteInfo/\(year)/\(month)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageDetailCommuteRecordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDetailCommuteRecord(result: response)
                    default:
                        vc.failedToRequestMyPageDetailCommuteRecord(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDetailCommuteRecord(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

