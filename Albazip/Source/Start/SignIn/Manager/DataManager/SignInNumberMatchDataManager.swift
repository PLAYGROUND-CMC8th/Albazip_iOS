//
//  SignInNumberMatchDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/28.
//

import Alamofire

class SignInNumberMatchDataManager {
    func getSignInNumberMatch(vc: SignInManagerInfoVC, number: String, name: String) {
        let url = "\(Constant.BASE_URL)/shop/number/match/\(number)/\(name)"
        let str_url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let header: HTTPHeaders = [ "Content-Type":"application/json;charset=utf-8"]
        
        AF.request(str_url!, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: SignInNumberMatchResponse.self) { response in
                switch response.result {
                case .success(let response):
                    vc.didSuccessSignInNumberMatch(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMatch(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
