//
//  HomeTodayWorkCheckDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
import Alamofire

class HomeTodayWorkCheckDatamanager {
    func getHomeTodayWorkCheck(taskId:Int, vc: HomeManagerTodayWorkVC) {
        let url = "\(Constant.BASE_URL)/home/todayTask/\(taskId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeWorkerTodayWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeTodayWorkCheck(result: response)
                    default:
                        vc.failedToRequestHomeTodayWorkCheck(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeTodayWorkCheck(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getHomeTodayWorkCheck(taskId:Int, vc: HomeWorkerTodayWorkVC) {
        let url = "\(Constant.BASE_URL)/home/todayTask/\(taskId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeWorkerTodayWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeTodayWorkCheck(result: response)
                    default:
                        vc.failedToRequestHomeTodayWorkCheck(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeTodayWorkCheck(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

