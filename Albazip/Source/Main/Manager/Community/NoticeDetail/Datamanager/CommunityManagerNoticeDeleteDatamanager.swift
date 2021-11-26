//
//  CommunityManagerNoticeDeleteDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//
import Alamofire
import Foundation
class CommunityManagerNoticeDeleteDatamanager {
    func getCommunityManagerNoticeDelete(noticeId: Int , vc: CommunityManagerNoticeAlertDeleteVC) {
        let url = "\(Constant.BASE_URL)/board/notice/\(noticeId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticeDeleteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNoticeDelete(result: response)
                    default:
                        vc.failedToRequestCommunityManagerNoticeDelete(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNoticeDelete(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
