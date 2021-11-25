//
//  HomeManagerTodayWorkDeleteDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
import Alamofire

class HomeManagerTodayWorkDeleteDatamanager {
    func getHomeManagerTodayWorkDelete(taskId: Int, vc: HomeManagerTodayWorkVC) {
        let url = "\(Constant.BASE_URL)/home/todayTask/\(taskId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeManagerTodayWorkDeleteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeManagerTodayWorkDelete(result: response)
                    default:
                        vc.failedToRequestHomeManagerTodayWorkDelete(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeManagerTodayWorkDelete(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

