//
//  HomeManagerEditStoreBeforeDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//
import Alamofire
import Foundation
class HomeManagerEditStoreBeforeDatamanager {
    func getHomeManagerEditStoreBefore(managerId:Int, vc: HomeManagerEditStore1VC) {
        let url = "\(Constant.BASE_URL)/shop/\(managerId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerEditStoreBeforeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerEditStore(result: response)
                    default:
                        vc.failedToRequestHomeManagerEditStore(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerEditStore(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
