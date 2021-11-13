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
                                    "token":"\(RegisterBasicInfo.shared.token!)"]
        
        AF.request("\(Constant.BASE_URL)/user/signup/worker", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: RegisterWorkerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        delegate.didSuccessRegisterWorker(response)
                        break
                    default:
                        delegate.failedToRegisterWorker(message: response.message)
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRegisterWorker(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
