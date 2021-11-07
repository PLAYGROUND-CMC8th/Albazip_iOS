//
//  MyPageManagerAddWorkerDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/07.
//

import Alamofire
class MyPageManagerAddWorkerDatamanager{
    func postAddWorker(_ parameters: MyPageManagerAddWorkerRequest, vc: MyPageManagerWorkListVC) {
        
        let header: HTTPHeaders = ["Content-Type":"application/json", "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Niwiam9iIjoiUzIiLCJpYXQiOjE2MzYyNjE2NTMsImV4cCI6MTYzODg1MzY1MywiaXNzIjoiQWxiYXppcFNlcnZlciJ9.SS2y0vWBma9qyKbZOc9oJXXHln-g5HRC6PR0ToA9NpM"]
        
        AF.request("\(Constant.BASE_URL)/position/", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerAddWorkerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessAddWorker(response)
                        break
                    default:
                        vc.failedToRequestAddWorker(message: response.message)
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestAddWorker(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
