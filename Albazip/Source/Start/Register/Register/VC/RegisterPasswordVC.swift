//
//  RegisterPasswordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
import RxSwift

class RegisterPasswordVC: UIViewController{
    private lazy var disposeBag = DisposeBag()
    private lazy var viewModel = RegisterPasswordViewModel()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCkTextField: UITextField!
    @IBOutlet weak var checkImage1: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkImage2: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    private func setupUI(){
        passwordTextField.addLeftPadding()
        passwordCkTextField.addLeftPadding()
        
        errorLabel.isHidden = true
        btnNext.isEnabled = false
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "6자리 이상 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        passwordCkTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호 재입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    private func setupBinding(){
        setTextFieldBinding()
        setBtnBinding()
    }
    
    private func setTextFieldBinding(){
        // 비밀번호
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.pwdText)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.passwordTextField.borderColor = .mainYellow
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidEnd])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.passwordTextField.borderColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        // 비밀번호 확인
        passwordCkTextField.rx.text.orEmpty
            .bind(to: viewModel.pwdCkText)
            .disposed(by: disposeBag)
        
        passwordCkTextField.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                if self.errorLabel.isHidden{
                    self.passwordCkTextField.borderColor = .mainYellow
                }else{
                    self.passwordCkTextField.borderColor = .red
                }
            })
            .disposed(by: disposeBag)
        
        passwordCkTextField.rx.controlEvent([.editingDidEnd])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.passwordCkTextField.borderColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        // 비밀번호 검사
        viewModel.checkPwd()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.checkImage1.image = $0.pwdCheck ? #imageLiteral(resourceName: "icCheckedCorrect") : #imageLiteral(resourceName: "icCheckedNormal")
                self.checkImage2.image = $0.pwdCkCheck ? #imageLiteral(resourceName: "icCheckedCorrect") : #imageLiteral(resourceName: "icCheckedNormal")
                self.btnNextEnable($0.nextBtnCheck)
                self.errorLabel.isHidden = $0.errorMsgHidden
                if $0.errorMsgHidden{
                    if self.passwordCkTextField.isFirstResponder{
                        self.passwordCkTextField.borderColor = .mainYellow
                    }else{
                        self.passwordCkTextField.borderColor = .lightGray
                    }
                }else{
                    self.passwordCkTextField.borderColor = .red
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setBtnBinding(){
        btnNext.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] in
                guard let self = self else { return }
                // 회원가입 데이터 저장
                let registerBasicInfo = RegisterBasicInfo.shared
                registerBasicInfo.pwd = self.passwordCkTextField.text!
                
                // 다음화면으로 이동
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterBasicInfoVC") as? RegisterBasicInfoVC else {return}
                self.navigationController?.pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        btnCancel.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func btnNextEnable(_ state: Bool){
        if state{
            btnNext.isEnabled = true
            btnNext.backgroundColor = .enableYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .disableYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
}
