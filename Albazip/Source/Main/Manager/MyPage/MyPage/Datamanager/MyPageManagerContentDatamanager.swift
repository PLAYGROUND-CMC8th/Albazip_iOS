//
//  MyPageManagerContentDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/12.
//

import Alamofire

class MyPageManagerContentDatamanager {
    func getMyPageManagerContent(vc: MyPageManagerContentVC) {
        let url = "\(Constant.BASE_URL)/mypage/workers"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(Constant.tokenManager)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerContentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerContent(result: response)
                    default:
                        vc.failedToRequestMyPageManagerContent(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerContent(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
