//
//  CommunityWorkerReportDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation
import Alamofire
class CommunityWorkerReportDatamanager{
    func postCommunityWorkerReport(_ parameters: CommunityWorkerReportRequest, delegate: CommunityWorkerNoticeAlertDetailVC) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request("\(Constant.BASE_URL)/board/notice/report", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: CommunityWorkerReportResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        delegate.didSuccessCommunityWorkerReport(result: response)
                        break
                    default:
                        delegate.failedToCommunityWorkerReport(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCommunityWorkerReport(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
