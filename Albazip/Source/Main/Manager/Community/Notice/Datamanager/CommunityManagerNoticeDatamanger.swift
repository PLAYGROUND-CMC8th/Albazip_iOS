//
//  CommunityManagerNoticeDatamanger.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
import Alamofire

class CommunityManagerNoticeDatamanger {
    func getCommunityManagerNotice(vc: CommunityManagerNoticeVC) {
        let url = "\(Constant.BASE_URL)/board/notice"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNotice(result: response)
                    default:
                        vc.failedToRequestCommunityManagerNotice(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNotice(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    func getCommunityWorkerNotice(vc: CommunityWorkerNoticeVC) {
        let url = "\(Constant.BASE_URL)/board/notice"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityWorkerNotice(result: response)
                    default:
                        vc.failedToRequestCommunityWorkerNotice(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityWorkerNotice(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

