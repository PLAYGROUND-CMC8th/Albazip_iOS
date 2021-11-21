//
//  HomeWorkerDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

import Alamofire

class HomeWorkerDatamanager {
    func getHomeWorker(vc: HomeWorkerVC) {
        let url = "\(Constant.BASE_URL)/home/worker"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HomeWorkerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessHomeWorker(result: response)
                    default:
                        vc.failedToRequestHomeWorker(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestHomeWorker(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

