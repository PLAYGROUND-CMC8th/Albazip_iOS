//
//  HomeManagerDeleteStoreDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation
import Alamofire

class HomeManagerDeleteStoreDatamanager {
    func deleteStore(managerId:Int, vc: HomeManagerDeleteStoreVC) {
        let url = "\(Constant.BASE_URL)/shop/\(managerId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerDeleteStoreResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerDeleteStore(result: response)
                    default:
                        vc.failedToRequestHomeManagerDeleteStore(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerDeleteStore(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
