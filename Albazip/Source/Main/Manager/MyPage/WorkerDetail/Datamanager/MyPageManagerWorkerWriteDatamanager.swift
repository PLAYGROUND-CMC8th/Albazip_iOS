//
//  MyPageManagerWorkerWriteDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
import Alamofire
class MyPageManagerWorkerWriteDatamanager {
    func getMyPageManagerWorkerWrite(vc: MyPageManagerWorkerWriteVC, index: Int) {
        let url = "\(Constant.BASE_URL)/mypage/workers/\(index)/taskList"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(Constant.tokenManager)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerWorkerWriteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerWorkerWrite(result: response)
                    default:
                        vc.failedToRequestMyPageManagerWorkerWrite(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerWorkerWrite(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
