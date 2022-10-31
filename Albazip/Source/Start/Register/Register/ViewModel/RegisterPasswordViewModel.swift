//
//  RegisterPasswordViewModel.swift
//  Albazip
//
//  Created by 김수빈 on 2022/10/31.
//

import RxSwift
import RxCocoa

struct RegisterPasswordViewModel{
    // 비밀번호 텍스트
    let pwdText = BehaviorRelay<String>(value: "")

    // 비밀번호 확인 텍스트
    let pwdCkText = BehaviorRelay<String>(value: "")
    
    struct PwdState {
        var pwdCheck: Bool
        var pwdCkCheck: Bool
        var nextBtnCheck: Bool
        var errorMsgHidden: Bool
    }
    
    func checkPwd() -> Driver<PwdState> {
        let output = Observable.combineLatest(pwdText, pwdCkText) {
            var pwdCheck = false
            var pwdCkCheck = false
            var nextBtnCheck = false
            var errorMsgHidden = true
            
            if($0.count >= 6){ // 비밀번호 6자 이상
                pwdCheck = true
                if $0 == $1{ // 비밀번호 일치
                    pwdCkCheck = true
                    nextBtnCheck = true
                }else{
                    errorMsgHidden = false
                }
            }
            
            if $1 == ""{
                errorMsgHidden = true
            }
            
            return PwdState(pwdCheck: pwdCheck,
                            pwdCkCheck: pwdCkCheck,
                            nextBtnCheck: nextBtnCheck,
                            errorMsgHidden: errorMsgHidden)
        }
        .asDriver(onErrorJustReturn:
                PwdState(pwdCheck: false,
                         pwdCkCheck: false,
                         nextBtnCheck: false,
                         errorMsgHidden: true)
        )
        return output
    }
}
