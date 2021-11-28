//
//  CommunityWorkerConfirmDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Alamofire

class CommunityWorkerConfirmDatamanager {
    func getCommunityWorkerNoticeDetail(noticeId:Int,vc: CommunityWorkerNoticeDetailVC) {
        let url = "\(Constant.BASE_URL)/board/notice/\(noticeId)/confirm"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of:  CommunityWorkerConfirmResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityWorkerConfirm(result: response)
                    default:
                        vc.failedToRequestCommunityWorkerConfirm(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityWorkerConfirm(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
