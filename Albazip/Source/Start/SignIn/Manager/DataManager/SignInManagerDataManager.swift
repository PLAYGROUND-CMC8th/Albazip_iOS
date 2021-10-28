//
//  SignInManagerDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/29.
//

import Alamofire
class SignInManagerDataManager{
    func postSignInManager(_ parameters: SignInManagerRequset, delegate: SignInMoreInfoVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/user/signup/manager", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: SignInManagerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    delegate.didSuccessSignInManager(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToSignInManager(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
