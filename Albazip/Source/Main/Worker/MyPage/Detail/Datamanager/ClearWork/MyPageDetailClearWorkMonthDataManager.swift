//
//  MyPageDetailClearWorkMonthDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Alamofire

class MyPageDetailClearWorkMonthDataManager {
    func getMyPageDetailClearWorkMonth(vc: MyPageDetailClearWorkMonthVC, year: String, month: String, positionId: Int) {
        var url = ""
        if positionId == -1{
            url = "\(Constant.BASE_URL)/mypage/myinfo/taskInfo/\(year)/\(month)"
        }else{
            url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)/workerInfo/taskInfo/\(year)/\(month)"
        }
        
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageDetailClearWorkMonthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDetailClearWorkMonth(result: response)
                    default:
                        vc.failedToRequestMyPageDetailClearWorkMonth(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDetailClearWorkMonth(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

