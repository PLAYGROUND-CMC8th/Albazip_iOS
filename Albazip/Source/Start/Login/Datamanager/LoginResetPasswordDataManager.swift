//
//  LoginResetPasswordDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/01.
//

import Alamofire
class LoginResetPasswordDataManager{
    func postLoginResetPassword(_ parameters: LoginResetPasswordRequest, delegate: LoginResetPasswordVC) {
        AF.request("\(Constant.BASE_URL)/user/signin/password", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResetPasswordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    
                    // 연결 성공했을 때
                    switch response.code {
                    case "200": delegate.didSuccessLoginResetPassword(response)
                    case "400": delegate.failedToRequestLoginResetPassword(message: response.message)
                    default: delegate.failedToRequestLoginResetPassword(message: response.message)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequestLoginResetPassword(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
