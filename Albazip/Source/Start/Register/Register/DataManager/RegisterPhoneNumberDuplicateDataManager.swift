//
//  RegisterPhoneDuplicateDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/01.
//

import Alamofire

class RegisterPhoneNumberDuplicateDataManager {
    func getRegisterPhoneNumberDuplicateDataManager(vc: RegisterPhoneNumberVC, number: String) {
        let url = "\(Constant.BASE_URL)/user/signup/\(number)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: RegisterPhoneNumberDuplicateResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessRegisterPhoneNumberExist(response)
                        break
                    default:
                        vc.failedToRequestRegisterPhoneNumberExist(message: response.message)
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestRegisterPhoneNumberExist(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    func getRegisterPhoneNumberDuplicateDataManager(vc: SettingEditPhoneNumberVC, number: String) {
        let url = "\(Constant.BASE_URL)/user/signup/\(number)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: RegisterPhoneNumberDuplicateResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessRegisterPhoneNumberExist(response)
                        break
                    default:
                        vc.failedToRequestRegisterPhoneNumberExist(message: response.message)
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestRegisterPhoneNumberExist(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
