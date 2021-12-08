//
//  MyPageWorkerProfileDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//
import Alamofire

class MyPageWorkerProfileDatamanager {
    func getMyPageManagerProfile(vc: MyPageWorkerVC) {
        let url = "\(Constant.BASE_URL)/mypage/profile"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerProfile(result: response)
                    default:
                        vc.failedToRequestMyPageManagerProfile(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    func getMyPageManagerProfile(vc: HomeWorkerTodayWorkVC) {
        let url = "\(Constant.BASE_URL)/mypage/profile"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        
        AF.request(url, method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageManagerProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageManagerProfile(result: response)
                    default:
                        vc.failedToRequestMyPageManagerProfile(message: response.message!)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageManagerProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

