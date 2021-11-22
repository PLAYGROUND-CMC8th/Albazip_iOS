//
//  HomeWorkerTodayWorkDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

import Alamofire

class HomeWorkerTodayWorkDatamanager {
    func getHomeWorkerTodayWork(vc: HomeWorkerTodayWorkVC) {
        let url = "\(Constant.BASE_URL)/home/todayTask/worker"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeWorkerTodayWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeWorkerTodayWork(result: response)
                    default:
                        vc.failedToRequestHomeWorkerTodayWork(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeWorkerTodayWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

