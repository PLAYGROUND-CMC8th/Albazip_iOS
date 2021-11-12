//
//  MyPageManagerWorkerDetailInfoDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Alamofire

class MyPageManagerWorkerInfoDataManager {
    func getMyPageWorkerMyInfo(vc: MyPageManagerWorkerInfoVC, index: Int) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(index)/workerInfo"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(Constant.tokenWorker)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageWorkerMyInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageWorkerMyInfo(result: response)
                    default:
                        vc.failedToRequestMyPageWorkerMyInfo(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageWorkerMyInfo(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

