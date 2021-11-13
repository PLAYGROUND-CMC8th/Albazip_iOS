//
//  LoginDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

import Alamofire
class LoginDataManager{
    func postLogin(_ parameters: LoginRequest, delegate: LoginViewController) {
        AF.request("\(Constant.BASE_URL)/user/signin", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        delegate.didSuccessLogin(response)
                        break
                    default:
                        delegate.failedToRequest(message: response.message)
                        break
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
