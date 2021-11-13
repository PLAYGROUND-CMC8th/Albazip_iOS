//
//  LoginResetPasswordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/18.
//

import UIKit

class LoginResetPasswordVC: UIViewController{
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCkTextField: UITextField!
    @IBOutlet weak var checkImage1: UIImageView!
    @IBOutlet weak var checkImage2: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    var phoneNumber = ""
    // Datamanager
    lazy var dataManager: LoginResetPasswordDataManager = LoginResetPasswordDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addLeftPadding()
        passwordCkTextField.addLeftPadding()
        errorLabel.isHidden = true
        passwordTextField.delegate = self
        passwordCkTextField.delegate = self
        btnNext.isEnabled = false
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "6자리 이상 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        passwordCkTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호 재입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        self.dismissKeyboardWhenTappedAround()
    }
    // 패스워드 유효성 검사
    func checkPassword(){
        if(passwordTextField.text!.count>=6){
            checkImage1.image = #imageLiteral(resourceName: "icCheckedCorrect")
            if let text = passwordCkTextField.text{
                if(text == passwordTextField.text!){
                    checkImage2.image = #imageLiteral(resourceName: "icCheckedCorrect")
                    btnNext.isEnabled = true
                    btnNext.backgroundColor = .mainYellow
                    btnNext.setTitleColor(.gray, for: .normal)
                    errorLabel.isHidden = true
                }else{
                    checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
                    btnNext.isEnabled = false
                    btnNext.backgroundColor = .semiYellow
                    btnNext.setTitleColor(.semiGray, for: .normal)
                    errorLabel.isHidden = false
                    passwordCkTextField.borderColor = .red
                }
                
            }else{
                checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
                btnNext.isEnabled = false
                btnNext.backgroundColor = .semiYellow
                errorLabel.isHidden = true
            }
        }else{
            checkImage1.image = #imageLiteral(resourceName: "icCheckedNormal")
            checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            errorLabel.isHidden = true
        }
        
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        dataManager.postLoginResetPassword(LoginResetPasswordRequest(phone: phoneNumber,pwd: passwordTextField.text!), delegate: self)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension LoginResetPasswordVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == passwordTextField){
            passwordTextField.borderColor = .mainYellow
            passwordCkTextField.borderColor = .lightGray
            
        }else if(textField == passwordCkTextField){
            passwordTextField.borderColor = .lightGray
            passwordCkTextField.borderColor = .mainYellow
        }
        checkPassword()
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        checkPassword()
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        checkPassword()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkPassword()
        return true
    }
}


extension LoginResetPasswordVC {
    func didSuccessLoginResetPassword(_ result: LoginResetPasswordResponse) {
        //MARK: 비밀번호 변경 완료!
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func failedToRequestLoginResetPassword(message: String) {
        self.presentAlert(title: message)
    }
}
