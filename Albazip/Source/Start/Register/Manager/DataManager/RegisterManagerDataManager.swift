//
//  RegisterManagerDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

import Alamofire
class RegisterManagerDataManager{
    func postRegisterManager(_ parameters: RegisterManagerRequset, delegate: RegisterMoreInfoVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(RegisterBasicInfo.shared.token!)"]
        
        AF.request("\(Constant.BASE_URL)/user/signup/manager", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: RegisterManagerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    delegate.didSuccessRegisterManager(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRegisterManager(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
