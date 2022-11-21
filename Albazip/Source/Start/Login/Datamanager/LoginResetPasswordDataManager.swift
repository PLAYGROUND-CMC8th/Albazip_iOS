//
//  LoginResetPasswordDataManager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/01.
//

import Alamofire
import RxSwift

class LoginResetPasswordDataManager{
    func postResetPassword(parameters: LoginResetPasswordRequest) -> Observable<LoginResetPasswordResponse> {
        return Observable.create { (observable) in
            let request = AF.request("\(Constant.BASE_URL)/user/signin/password",
                                     method: .post, parameters: parameters,
                                     encoder: JSONParameterEncoder(),
                                     headers: nil)
            .validate()
            .responseDecodable(of: LoginResetPasswordResponse.self) { response in
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
