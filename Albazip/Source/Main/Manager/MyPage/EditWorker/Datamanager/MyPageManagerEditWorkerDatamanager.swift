//
//  MyPageManagerEditWorkerDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

import Foundation
import Alamofire
class MyPageManagerEditWorkerDatamanager {
    func getMyPageManagerEditWorker(vc: MyPageManagerEditWorkerVC, index: Int) {
        let url = "\(Constant.BASE_URL)/position/\(index)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerEditWorkerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageMyPageManagerEditWorker(response)
                    default:
                        vc.failedToRequestMyPageManagerEditWorker(message: response.message)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerEditWorker(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
