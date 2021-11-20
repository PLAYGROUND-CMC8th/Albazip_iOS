//
//  SettingEditBasicInfoDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/16.
//

import Alamofire
class SettingEditBasicInfoDatamanager{
    func postSettingEditBasicInfo(_ parameters: SettingEditBasicInfoRequest, delegate: SettingEditBasicInfoVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/mypage/setting/myinfo", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: SettingEditBasicInfoResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        delegate.didSuccessSettingEditBasicInfo(result: response)
                        break
                    default:
                        delegate.failedToRequestSettingEditBasicInfo(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequestSettingEditBasicInfo(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
