//
//  CommunityManagerNoticeDetailDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/26.
//

import Foundation
import Alamofire

class CommunityManagerNoticeDetailDatamanager {
    func getCommunityManagerNoticeDetail(noticeId: Int , vc: CommunityManagerNoticeDetailVC) {
        let url = "\(Constant.BASE_URL)/board/notice/\(noticeId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticeDetailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNoticeDetail(result: response)
                    default:
                        vc.failedToRequestCommunityManagerNoticeDetail(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNoticeDetail(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
