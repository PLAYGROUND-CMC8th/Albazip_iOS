//
//  MyPageDeletePositionDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Alamofire
import Foundation
class MyPageDeletePositionDatamanager {
    func deletePosition( positionId: Int, vc: MyPageManagerWorkerPositionDelete2VC) {
        let url = "\(Constant.BASE_URL)/position/\(positionId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageStopWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDeletePosition(result: response)
                    default:
                        vc.failedToRequestMyPageDeletePosition(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDeletePosition(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    func deletePosition( positionId: Int, vc: MyPageManagerWorkerPositionDeleteVC) {
        let url = "\(Constant.BASE_URL)/position/\(positionId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .delete ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageStopWorkResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageDeletePosition(result: response)
                    default:
                        vc.failedToRequestMyPageDeletePosition(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageDeletePosition(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

