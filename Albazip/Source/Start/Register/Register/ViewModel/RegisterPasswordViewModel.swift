//
//  RegisterPasswordViewModel.swift
//  Albazip
//
//  Created by 김수빈 on 2022/10/31.
//

import RxSwift
import RxCocoa

struct RegisterPasswordViewModel{
    let network = LoginResetPasswordDataManager()
    let disposeBag = DisposeBag()
    
    // 비밀번호 텍스트
    let pwdText = BehaviorRelay<String>(value: "")

    // 비밀번호 확인 텍스트
    let pwdCkText = BehaviorRelay<String>(value: "")
    
    // 비밀번호 관련 상태값
    struct PwdState {
        var pwdCheck: Bool = false
        var pwdCkCheck: Bool = false
        var nextBtnCheck: Bool = false
        var errorMsgHidden: Bool = true
    }
    
    func checkPwd() -> Driver<PwdState> {
        let output = Observable.combineLatest(pwdText, pwdCkText) {
            var state = PwdState()
            
            if($0.count >= 6){ // 비밀번호 6자 이상
                state.pwdCheck = true
                if $0 == $1{ // 비밀번호 일치
                    state.pwdCkCheck = true
                    state.nextBtnCheck = true
                }else{
                    state.errorMsgHidden = false
                }
            }
            
            if $1 == ""{
                state.errorMsgHidden = true
            }
            
            return state
        }
        .asDriver(onErrorJustReturn:PwdState())
        return output
    }
    
    func postResetPassword(phoneNumber: String, completion: @escaping (Result<LoginResetPasswordResponse, Error>) -> Void){
        let request = LoginResetPasswordRequest(phone: phoneNumber,
                                                pwd: self.pwdText.value)
        network.postResetPassword(parameters: request)
            .subscribe(
                onNext: { result in
                    return completion(.success(result))
            },
                onError: { error in
                    return completion(.failure(error))
            })
            .disposed(by: disposeBag)
    }
}
