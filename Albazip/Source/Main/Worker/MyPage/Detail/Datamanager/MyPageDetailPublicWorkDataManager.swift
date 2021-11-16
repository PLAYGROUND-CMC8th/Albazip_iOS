//
//  MyPageDetailPublicWorkDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
import Alamofire

class MyPageDetailPublicWorkDataManager {
    func getMyPageDetailPublicWork(vc: MyPageDetailPublicWorkVC, positionId: Int) {
        var url = ""
        if positionId == -1{
            url = "\(Constant.BASE_URL)/mypage/myinfo/taskInfo/coTaskInfo"
        }else{
            url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)/workerInfo/coTaskInfo"
        }
        
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageDetailPublicWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDetailPublicWork(result: response)
                    default:
                        vc.failedToRequestMyPageDetailPublicWork(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDetailPublicWork(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

