//
//  HomeManagerTodayWorkDetailDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import Foundation
import Alamofire

class HomeManagerTodayWorkDetailDatamanager {
    func getHomeManagerTodayWorkDetail(workerId: Int, vc: HomeManagerTodayWorkDetailVC) {
        let url = "\(Constant.BASE_URL)/home/todayTask/manager/workerPerTask/\(workerId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerTodayWorkDetailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerTodayWorkDetail(result: response)
                    default:
                        vc.failedToRequestHomeManagerTodayWorkDetail(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerTodayWorkDetail(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

