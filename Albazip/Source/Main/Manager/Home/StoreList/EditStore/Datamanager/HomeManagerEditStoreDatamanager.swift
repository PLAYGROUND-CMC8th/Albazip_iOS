//
//  HomeManagerEditStoreDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Alamofire
import Foundation
class HomeManagerEditStoreDatamanager {
    func postEditStore(managerId: Int, _ parameters: HomeManagerEditStoreRequest, delegate: HomeManagerEditStore2VC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/shop/\(managerId)", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: HomeManagerEditStoreReponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        delegate.didSuccessEditStore(result: response)
                        break
                    default:
                        delegate.failedToEditStore(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToEditStore(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
