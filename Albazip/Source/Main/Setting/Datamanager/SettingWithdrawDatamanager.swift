//
//  SettingWithdrawDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//
import Alamofire
import Foundation
class SettingWithdrawDatamanager {
    func getSettingWithdraw(vc: SettingWithdrawVC) {
        let url = "\(Constant.BASE_URL)/mypage/setting"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: SettingWithdrawResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessSettingWithdraw(result: response)
                    default:
                        vc.failedToRequestSettingWithdraw(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestSettingWithdraw(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

