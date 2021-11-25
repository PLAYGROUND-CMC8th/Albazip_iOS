//
//  HomeManagerAddPublicWorkDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
import Alamofire
class HomeManagerAddPublicWorkDatamanager{
    func postHomeManagerAddPublicWork(_ parameters: HomeManagerAddPublicWorkRequest, delegate: HomeManagerAddPublicWorkVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/home/todayTask/coTask", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: HomeManagerAddPublicWorkResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        delegate.didSuccessHomeManagerAddPublicWork(result: response)
                        break
                    default:
                        delegate.failedToRequestHomeManagerAddPublicWork(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequestHomeManagerAddPublicWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
