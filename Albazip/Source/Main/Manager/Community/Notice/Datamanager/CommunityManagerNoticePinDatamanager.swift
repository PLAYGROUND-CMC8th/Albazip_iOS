//
//  CommunityManagerNoticePinDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/26.
//

import Foundation
import Alamofire

class CommunityManagerNoticePinDatamanager {
    func getCommunityManagerNoticePin(noticeId:Int, vc: CommunityManagerNoticeVC) {
        let url = "\(Constant.BASE_URL)/board/notice/pin/\(noticeId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticePinResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNoticePin(result: response)
                    case "202":
                        vc.didSuccessCommunityManagerNoticePinOver(message: response.message!)
                    default:
                        vc.failedToRequestCommunityManagerNoticePin(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNoticePin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getCommunityManagerNoticePin(noticeId:Int, vc: MyPageManagerWriteVC) {
        let url = "\(Constant.BASE_URL)/board/notice/pin/\(noticeId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunityManagerNoticePinResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNoticePin(result: response)
                    case "202":
                        vc.didSuccessCommunityManagerNoticePinOver(message: response.message!)
                    default:
                        vc.failedToRequestCommunityManagerNoticePin(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNoticePin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
