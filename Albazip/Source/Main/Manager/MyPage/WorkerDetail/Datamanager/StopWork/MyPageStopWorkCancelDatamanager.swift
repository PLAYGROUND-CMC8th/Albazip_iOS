//
//  MyPageStopWorkCancelDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/12/08.
//

import Alamofire
import Foundation
class MyPageStopWorkCancelDatamanager {
    func cancelMyPageStopWork( positionId: Int, vc: MyPageManagerWorkerExitVC) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageStopWorkCancelResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageStopWorkCancel(result: response)
                    default:
                        vc.failedToRequestMyPageStopWorkCancel(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageStopWorkCancel(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
