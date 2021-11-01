//
//  RegisterNumberExist.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/28.
//

import Alamofire

class RegisterNumberExistDataManager {
    func getRegisterNumberExist(vc: RegisterManagerInfoVC, number: String) {
        let url = "\(Constant.BASE_URL)/shop/number/exist/\(number)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: RegisterNumberExistResponse.self) { response in
                switch response.result {
                case .success(let response):
                    vc.didSuccessRegisterNumberExist(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

