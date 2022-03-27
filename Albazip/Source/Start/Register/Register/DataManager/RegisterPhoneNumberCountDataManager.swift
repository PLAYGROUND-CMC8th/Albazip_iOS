//
//  RegisterPhoneNumberCountDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2022/03/27.
//

import Alamofire

class RegisterPhoneNumberCountDataManager {
    func getRegisterPhoneNumberCountDataManager(vc: RegisterPhoneNumberVC, number: String) {
        let url = "\(Constant.BASE_URL)/user/signup/limit/\(number)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: RegisterPhoneNumberCountResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessRegisterPhoneNumberCount(response)
                        break
                    case "202":
                        vc.didOverRegisterPhoneNumberCount(response)
                        break
                    default:
                        vc.failedToRequestRegisterPhoneNumberCount(message: response.message)
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestRegisterPhoneNumberCount(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
