//
//  MyPageManagerWriteDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

import Alamofire

class MyPageManagerWriteDatamanager {
    func getMyPageManagerWrite(vc: MyPageManagerWriteVC) {
        let url = "\(Constant.BASE_URL)/mypage/boards/manager"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(Constant.tokenManager)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerWriteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerWrite(result: response)
                    default:
                        vc.failedToRequestMyPageManagerWrite(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerWrite(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

