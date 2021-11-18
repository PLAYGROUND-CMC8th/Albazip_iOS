//
//  MyPageWorkerStopWorkDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/19.
//

import Foundation
import Alamofire

class MyPageWorkerStopWorkDatamanager {
    func putMyPageWorkerStopWork(vc: MyPageWorkerInfoVC) {
        let url = "\(Constant.BASE_URL)/mypage/myinfo/resign"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageWorkerStopWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMMyPageWorkerStopWork(result: response)
                    default:
                        vc.failedToRequestMyPageWorkerStopWork(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageWorkerStopWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

