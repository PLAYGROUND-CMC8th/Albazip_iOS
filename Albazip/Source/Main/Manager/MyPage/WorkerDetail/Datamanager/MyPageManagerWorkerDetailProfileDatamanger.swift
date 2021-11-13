//
//  MyPageManagerWorkerDetailProfileDataManger.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

import Alamofire

class MyPageManagerWorkerDetailProfileDataManger {
    func getMyPageManagerWorkerDetailProfile(vc: MyPageManagerWorkerDetailVC, index :Int) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(index)/profile"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerWorkerDetailProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerWorkerDetailProfile(result: response)
                    default:
                        vc.failedToRequestMyPageManagerWorkerDetailProfile(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerWorkerDetailProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
