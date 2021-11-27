//
//  HomeManagerStoreListDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
import Alamofire

class HomeManagerStoreListDatamanager {
    func getHomeManagerStoreList(vc: HomeManagerStoreListVC) {
        let url = "\(Constant.BASE_URL)/home/shopList"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerStoreListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerStoreList(result: response)
                    default:
                        vc.failedToRequestHomeManagerStoreList(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerStoreList(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getHomeWorkerStoreList(vc: HomeWorkerStoreListVC) {
        let url = "\(Constant.BASE_URL)/home/shopList"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerStoreListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerStoreList(result: response)
                    default:
                        vc.failedToRequestHomeManagerStoreList(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerStoreList(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

