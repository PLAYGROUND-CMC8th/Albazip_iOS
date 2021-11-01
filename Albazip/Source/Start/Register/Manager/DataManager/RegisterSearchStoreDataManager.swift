//
//  RegisterSearchStoreDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/24.
//

import Foundation
import Alamofire

class RegisterSearchStoreDataManager {
    func searchStore(vc: RegisterSearchStoreVC, searchText: String) {
        let url = "\(Constant.KAKAO_MAP_URL)"
        let parameters: [String: Any] = [ "query": searchText ]
        let header: HTTPHeaders = [ "Authorization":"\(Constant.KAKAO_KEY)"]
        
        AF.request(url, method: .get ,parameters: parameters, headers: header)
            .validate()
            .responseDecodable(of: RegisterSearchStoreResponse.self) { response in
                switch response.result {
                case .success(let response):
                    vc.didSuccessSearchStore(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToSearchStore(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
