//
//  MyPageManagerProfileDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//
import Alamofire

class MyPageManagerProfileDatamanager {
    func getMyPageManagerProfile(vc: MyPageManagerVC) {
        let url = "\(Constant.BASE_URL)/mypage/profile"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(Constant.tokenManager)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerProfile(result: response)
                    default:
                        vc.failedToRequestMyPageManagerProfile(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}