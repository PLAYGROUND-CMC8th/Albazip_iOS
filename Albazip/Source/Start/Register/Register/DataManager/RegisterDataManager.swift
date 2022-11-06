//
//  RegisterDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

import Alamofire
import RxSwift

class RegisterDataManager{
    func postRegister(parameters: RegisterRequest) -> Observable<RegisterResponse> {
        return Observable.create { (observable) in
            let request = AF.request("\(Constant.BASE_URL)/user/signup",
                                     method: .post, parameters: parameters,
                                     encoder: JSONParameterEncoder(),
                                     headers: nil)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(let response):
                    observable.onNext(response)
                    observable.onCompleted()
                case .failure(let error):
                    observable.onError(error)
                    observable.onCompleted()
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
