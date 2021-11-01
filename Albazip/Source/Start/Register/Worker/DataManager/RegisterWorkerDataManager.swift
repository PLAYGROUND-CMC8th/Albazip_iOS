//
//  RegisterWorkerDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/31.
//

import Alamofire
class RegisterWorkerDataManager{
    func postRegisterWorker(_ parameters: RegisterWorkerRequset, delegate: RegisterWorkerCodeVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/user/signup/worker", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: RegisterWorkerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    delegate.didSuccessRegisterWorker(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRegisterWorker(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
