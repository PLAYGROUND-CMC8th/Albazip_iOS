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
        //포지션 선택 > 설정인지, 마이페이지 > 설정인지 토큰 구분해주기
        var token = ""
        if let x = UserDefaults.standard.string(forKey: "token"), x != ""{
            token = x
        }else{
            let data = RegisterBasicInfo.shared
            token = data.token!
        }
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(token)"]
        
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

