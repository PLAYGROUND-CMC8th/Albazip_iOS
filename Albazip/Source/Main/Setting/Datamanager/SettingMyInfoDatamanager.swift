//
//  SettingMyInfoDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/16.
//

import Alamofire

class SettingMyInfoDatamanager {
    func getSettingMyInfo(vc: SettingMyInfoVC) {
        let url = "\(Constant.BASE_URL)/mypage/setting/myinfo"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: SettingMyInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessSettingMyInfo(result: response)
                    default:
                        vc.failedToRequestSettingMyInfo(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestSettingMyInfo(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

