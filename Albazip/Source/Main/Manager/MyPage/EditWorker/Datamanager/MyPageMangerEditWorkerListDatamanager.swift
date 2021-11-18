//
//  MyPageManagerEditWorkerListDataManger.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

import Foundation
import Alamofire
class MyPageManagerEditWorkerListDataManger{
    func getMyPageManagerEditWorkerList(_ parameters: MyPageManagerEditWorkerData2,vc: MyPageManagerEditWorkerListVC, index: Int) {
        let url = "\(Constant.BASE_URL)/position/\(index)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .post ,parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: MyPageEditWorkerListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerEditWorkerList( result: response)
                    default:
                        vc.failedToRequestMyPageEditWorkerList(message: response.message)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageEditWorkerList(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
