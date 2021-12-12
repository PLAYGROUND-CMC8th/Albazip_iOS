//
//  MyPageStopWorkDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Alamofire
import Foundation
class MyPageStopWorkDatamanager {
    func deleteMyPageStopWork( positionId: Int, vc: MyPageManagerWorkerExitVC) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageStopWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageStopWork(result: response)
                    default:
                        vc.failedToRequestMyPageStopWork(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageStopWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func deleteMyPageStopWork( positionId: Int, vc: MyPageManagerWorkerDirectExitVC) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageStopWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageStopWork(result: response)
                    default:
                        vc.failedToRequestMyPageStopWork(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageStopWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

