//
//  LoginResetPhoneVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/18.
//

import UIKit
import FirebaseAuth

class LoginResetPhoneVC: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var checkNumberTextField: UITextField!
    @IBOutlet var btnConfirm: UIButton!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnReAuth: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    
    var limitTime : Int = 120 //3분
    var currentVerificationId = ""
    var isFirstAuth = true
    var isTimerWork = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        phoneNumberTextField.addLeftPadding()
        checkNumberTextField.addLeftPadding()
        
        phoneNumberTextField.delegate = self
        checkNumberTextField.delegate = self
        
        self.dismissKeyboardWhenTappedAround()
        
        checkNumberTextField.isHidden = true
        btnReAuth.isHidden = true
        timerLabel.isHidden = true
        errorLabel.isHidden = true
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "-없이 번호 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
    }
    
    @objc func getSetTime(){
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func secToTime(sec: Int)  {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        if second < 10 {
            timerLabel.text = String(minute) + ":" + "0" + String(second)
        }else{
            timerLabel.text = String(minute) + ":" + String(second)
        }
        if limitTime != 0{
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        }
        else if limitTime == 0{
            //checkNumberTextField.isHidden = true
            //btnReAuth.isHidden = true
            //timerLabel.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = "인증번호가 입력시간이 초과되었습니다. 재발송 해주세요."
            isTimerWork = false
        }
    }
    
    @IBAction func btnAuth(_ sender: Any) {
        errorLabel.isHidden = true
        Auth.auth().accessibilityLanguage = "kr";
        
        if let phoneNumber = phoneNumberTextField.text{
        
            PhoneAuthProvider.provider().verifyPhoneNumber("+82\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }

                  self.currentVerificationId = verificationID!
                    
                }
            self.timerLabel.isHidden = false
            self.btnReAuth.isHidden = false
            self.checkNumberTextField.isHidden = false
            if(self.isTimerWork){
                self.limitTime = 120
            }else{
                self.getSetTime()
                self.isTimerWork = true
                //self.isFirstAuth = false
            }
            
            if(self.isFirstAuth){
                self.isFirstAuth = false
                
                btnNext.isEnabled = true
                btnNext.backgroundColor = .enableYellow
                btnNext.setTitleColor(.gray, for: .normal)
            }
        }
        
        //UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
    }
    
    @IBAction func btnReAuth(_ sender: Any) {
        errorLabel.isHidden = true
        Auth.auth().accessibilityLanguage = "kr";
        
        if let phoneNumber = phoneNumberTextField.text{
          
            PhoneAuthProvider.provider().verifyPhoneNumber("+82\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }

                  self.currentVerificationId = verificationID!
                }
            if(self.isTimerWork){
                self.limitTime = 120
            }else{
                self.getSetTime()
                self.isTimerWork = true
                //self.isFirstAuth = false
            }
            
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID:currentVerificationId,verificationCode: checkNumberTextField.text!)
        
        Auth.auth().signIn(with: credential){ [self](success, error) in
            if error == nil{
                print(success ?? "")
                print("User Signed in...")
                
                // 인증 성공! 다음 화면으로 이동
                self.errorLabel.isHidden = true
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginResetPasswordVC") as? LoginResetPasswordVC else {return}
                nextVC.phoneNumber = self.phoneNumberTextField.text!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                // 인증 실패
                print(error.debugDescription)
                self.errorLabel.isHidden = false
                self.errorLabel.text = "인증번호가 일치하지 않습니다."
            }
        }
    }
    
    
    // MARK: 텍스트 필드 포커스 시, 테두리색 변경
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == checkNumberTextField){
            checkNumberTextField.borderColor = .mainYellow
            phoneNumberTextField.borderColor = .lightGray
            
        }else if(textField == phoneNumberTextField){
            checkNumberTextField.borderColor = .lightGray
            phoneNumberTextField.borderColor = .mainYellow
        }
        btnConfirm.isEnabled = true
        btnConfirm.setImage(#imageLiteral(resourceName: "btnActive"), for: .normal)
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
    }
}
