//
//  SignInPhoneDuplicateDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/01.
//

import Alamofire

class SignInPhoneNumberDuplicateDataManager {
    func getSignInPhoneNumberDuplicateDataManager(vc: SigInPhoneNumberVC, number: String) {
        let url = "\(Constant.BASE_URL)/user/signup/\(number)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: SignInPhoneNumberDuplicateResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessSignInPhoneNumberExist(response)
                        break
                    default:
                        vc.failedToRequestSignInPhoneNumberExist(message: response.message)
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestSignInPhoneNumberExist(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
