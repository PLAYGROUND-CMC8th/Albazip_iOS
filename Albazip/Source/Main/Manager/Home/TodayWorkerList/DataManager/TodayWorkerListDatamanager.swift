//
//  TodayWorkerListDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

import Foundation
import Alamofire

class TodayWorkerListDatamanager {
    func getTodayWorkerList(vc: HomeManagerWorkerTodayWorkerListVC) {
        let url = "\(Constant.BASE_URL)/home/todayWorkers"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: TodayWorkerListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessTodayWorkerList(result: response)
                    default:
                        vc.failedToRequestTodayWorkerList(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestTodayWorkerList(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

