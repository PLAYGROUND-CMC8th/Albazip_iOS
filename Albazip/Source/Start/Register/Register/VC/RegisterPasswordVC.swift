//
//  SigInPasswordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class RegisterPasswordVC: UIViewController{
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCkTextField: UITextField!
    @IBOutlet weak var checkImage1: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkImage2: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    
    
    @IBAction func btnNext(_ sender: Any) {
        // 회원가입 데이터 저장
        let registerBasicInfo = RegisterBasicInfo.shared
        registerBasicInfo.pwd = passwordCkTextField.text!
        
        //다음 뷰컨으로 이동
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterBasicInfoVC") as? RegisterBasicInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // 패스워드 유효성 검사
    func checkPassword(){
        if(passwordTextField.text!.count>=6){
            checkImage1.image = #imageLiteral(resourceName: "icCheckedCorrect")
            if let text = passwordCkTextField.text{
                if(text == passwordTextField.text!){
                    checkImage2.image = #imageLiteral(resourceName: "icCheckedCorrect")
                    btnNext.isEnabled = true
                    btnNext.backgroundColor = .enableYellow
                    btnNext.setTitleColor(.gray, for: .normal)
                    errorLabel.isHidden = true
                }else{
                    checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
                    btnNext.isEnabled = false
                    btnNext.backgroundColor = .disableYellow
                    btnNext.setTitleColor(.semiGray, for: .normal)
                    errorLabel.isHidden = false
                    passwordCkTextField.borderColor = .red
                }
                
            }else{
                checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
                btnNext.isEnabled = false
                btnNext.backgroundColor = .disableYellow
                btnNext.setTitleColor(.semiGray, for: .normal)
                errorLabel.isHidden = true
            }
        }else{
            checkImage1.image = #imageLiteral(resourceName: "icCheckedNormal")
            checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
            btnNext.isEnabled = false
            btnNext.backgroundColor = .disableYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
            errorLabel.isHidden = true
        }
        
    }
}

extension RegisterPasswordVC: UITextFieldDelegate{
    
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
