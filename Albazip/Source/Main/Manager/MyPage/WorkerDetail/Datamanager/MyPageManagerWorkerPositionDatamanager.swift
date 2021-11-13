//
//  MyPageManagerWorkerPositionDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Alamofire
class MyPageManagerWorkerPositionDatamanager {
    func getMyPageManagerWorkerPosition(vc: MyPageManagerWorkerPositionVC, index: Int) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(index)/positionInfo"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerWorkerPositionResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerWorkerPosition(result: response)
                    default:
                        vc.failedToRequestMyPageManagerWorkerPosition(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerWorkerPosition(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
