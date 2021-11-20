//
//  MyPageDetailClearWorkDayDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Alamofire

class MyPageDetailClearWorkDayDatamanager {
    func getMyPageDetailClearWorkDay(vc: MyPageDetailClearWorkDayVC, year: String, month: String, day:String, positionId: Int) {
        var url = ""
        if positionId == -1{
            url = "\(Constant.BASE_URL)/mypage/myinfo/taskInfo/\(year)/\(month)/\(day)"
        }else{
            url = "\(Constant.BASE_URL)/mypage/workers/\(positionId)/workerInfo/taskInfo/\(year)/\(month)/\(day)"
        }
        
        print("url: \(url)")
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageDetailClearWorkDayResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDetailClearWorkDay(result: response)
                    default:
                        vc.failedToRequestMyPageDetailClearWorkDay(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDetailClearWorkDay(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

