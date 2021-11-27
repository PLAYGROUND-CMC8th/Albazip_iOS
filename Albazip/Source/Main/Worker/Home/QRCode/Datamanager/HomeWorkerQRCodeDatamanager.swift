//
//  HomeWorkerQRCodeDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//
import Alamofire
import Foundation
class HomeWorkerQRCodeDatamanager {
    func putHomeWorkerQRCode(vc: HomeWorkerQRCodeVC) {
        let url = "\(Constant.BASE_URL)/home/clock"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .put ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeWorkerQRCodeReponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeWorkerQRCode(result: response)
                    default:
                        vc.failedToRequestHomeWorkerQRCode(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeWorkerQRCode(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

