//
//  StartTokenCheckDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
import Alamofire
class StartTokenCheckDatamanager {
    func getStartTokenCheck(vc: StartViewController) {
        let url = "\(Constant.BASE_URL)/token"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: StartTokenCheckResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessStartTokenCheck(result: response)
                    default:
                        vc.failedToRequestStartTokenCheck(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestStartTokenCheck(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
