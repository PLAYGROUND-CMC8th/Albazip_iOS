//
//  CommunityWorkerSearchDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/28.
//

import Foundation
import Alamofire

class CommunityWorkerSearchDatamanager {
    func getCommunityWorkerSearch(searchWord:String ,vc: CommunityWorkerSearchVC) {
        let url = "\(Constant.BASE_URL)/board/notice/search/word/\(searchWord)"
        print(url)
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

     
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(encodedString, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunitySearchResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityWorkerSearch(result: response)
                    default:
                        vc.failedToRequestCommunityWorkerSearch(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityWorkerSearch(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getCommunityWorkerSearch(searchWord:String ,vc: CommunityManagerSearchVC) {
        let url = "\(Constant.BASE_URL)/board/notice/search/word/\(searchWord)"
        print(url)
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

     
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(encodedString, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommunitySearchResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityWorkerSearch(result: response)
                    default:
                        vc.failedToRequestCommunityWorkerSearch(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityWorkerSearch(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

