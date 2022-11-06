//
//  RegisterBasicViewModel.swift
//  Albazip
//
//  Created by 김수빈 on 2022/11/02.
//

import RxSwift
import RxCocoa

struct RegisterBasicViewModel {
    let network = RegisterDataManager()
    let disposeBag = DisposeBag()
    
    let firstName = BehaviorRelay<String>(value: "")
    let lastName = BehaviorRelay<String>(value: "")
    let age = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<String>(value: "")
    
    init(){
    }
    
    func isNextButtonEnable() -> Observable<Bool>{
        let output = Observable.combineLatest(
            firstName,
            lastName,
            age,
            gender
        ).map {
            return !$0.0.isEmpty
            && !$0.1.isEmpty
            && !$0.2.isEmpty
            && !$0.3.isEmpty
        }
        
        return output
    }
    
    func postRegister(completion: @escaping (RegisterResponse?, String?) -> Void){
        network.postRegister(parameters: setupRequest())
            .subscribe(
                onNext: { result in
                    if result.data == nil{
                        return completion(nil, result.message)
                    }else{
                        let data = RegisterBasicInfo.shared
                        // 토큰 정보 저장
                        data.token = result.data?.token.token
                        // 이름 정보 저장
                        data.firstName = firstName.value
                        
                        return completion(result, nil)
                    }
            },
                onError: { error in
                    return completion(nil, "서버와의 연결이 원활하지 않습니다")
            })
            .disposed(by: disposeBag)
    }
    
    func setupRequest() -> RegisterRequest{
        let registerBasicInfo = RegisterBasicInfo.shared
        return RegisterRequest(phone: registerBasicInfo.phone!,
                                    pwd: registerBasicInfo.pwd!,
                                    lastName: self.lastName.value,
                                    firstName: self.firstName.value,
                                    birthyear: self.age.value,
                                    gender: self.gender.value)
    }
}
