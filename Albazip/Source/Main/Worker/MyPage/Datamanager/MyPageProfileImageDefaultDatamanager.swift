//
//  MyPageProfileImageDefaultDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/17.
//

import Foundation
import Alamofire

class MyPageProfileImageDefaultDatamanager {
    func postMyPageProfileImageDefault(_ parameters: MyPageProfileImageDefaultRequest, vc: MyPageWorkerSelectProfileImageVC) {
        let url = "\(Constant.BASE_URL)/mypage/profile/image"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/mypage/profile/image", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: MyPageProfileImageDefaultResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageProfileImageDefault(result: response)
                        break
                    default:
                        vc.failedToRequestMyPageProfileImageDefault(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageProfileImageDefault(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    func postMyPageProfileImageDefault(_ parameters: MyPageProfileImageDefaultRequest, vc: MyPageManagerSelectProfileImageVC) {
        let url = "\(Constant.BASE_URL)/mypage/profile/image"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/mypage/profile/image", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: MyPageProfileImageDefaultResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageProfileImageDefault(result: response)
                        break
                    default:
                        vc.failedToRequestMyPageProfileImageDefault(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageProfileImageDefault(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}


