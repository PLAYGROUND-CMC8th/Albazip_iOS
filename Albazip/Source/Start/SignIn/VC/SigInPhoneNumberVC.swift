//
//  SigInPhoneNumberVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
import FirebaseAuth

class SigInPhoneNumberVC: UIViewController, UITextFieldDelegate{
    
    //MARK: - Outlet
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var checkNumberTextField: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnReAuth: UIButton!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var errorLabel: UILabel!
    
    
    var limitTime : Int = 120 //3분
    var currentVerificationId = ""
    var isFirstAuth = true
    var isTimerWork = false
    var phoneNumber = ""
    
    //휴대폰 중복 api 땜에 만들어진 변수
    var isReAuth = false
    var currentNumber = ""
    
    // Datamanager
    lazy var dataManager: SignInPhoneNumberDuplicateDataManager = SignInPhoneNumberDuplicateDataManager()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    //휴대폰 번호가 중복되는 번호가 아니라면 문자메시지 보내는 함수 수행!!(인증버튼)
    func phoneAuth(phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber("+82\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error.localizedDescription)
                return
              }

              self.currentVerificationId = verificationID!
              self.phoneNumber = phoneNumber
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
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func btnAuth(_ sender: Any) {
        errorLabel.isHidden = true
        Auth.auth().accessibilityLanguage = "kr";
        
        if phoneNumberTextField.text!.count > 0{
            isReAuth = false
            currentNumber = phoneNumberTextField.text!
            //핸드폰 번호 중복 검사 api
            dataManager.getSignInPhoneNumberDuplicateDataManager(vc: self, number: currentNumber)
        }
        
        //UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
    }
    
    //휴대폰 번호가 중복되는 번호가 아니라면 문자메시지 보내는 함수 수행!!(재인증버튼)
    func phoneReAuth(phoneNumber: String){
        PhoneAuthProvider.provider().verifyPhoneNumber("+82\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error.localizedDescription)
                return
              }
              self.phoneNumber = phoneNumber
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
    
    
    // 재인증 버튼
    @IBAction func btnReAuth(_ sender: Any) {
        errorLabel.isHidden = true
        Auth.auth().accessibilityLanguage = "kr";
        
        if let phoneNumber = phoneNumberTextField.text{
            isReAuth = true
            currentNumber = phoneNumberTextField.text!
            //핸드폰 번호 중복 검사 api
            dataManager.getSignInPhoneNumberDuplicateDataManager(vc: self, number: currentNumber)
        }
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.currentVerificationId,verificationCode: checkNumberTextField.text!)
        
        Auth.auth().signIn(with: credential){(success, error) in
            if error == nil{
                print(success ?? "")
                print("User Signed in...")
                
                // 인증 성공! 다음 화면으로 이동
                self.errorLabel.isHidden = true
                
                // 회원가입 데이터 저장
                let signInBasicInfo = SignInBasicInfo.shared
                signInBasicInfo.phone = self.phoneNumber
                
                //사용자 로그아웃
                
                
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SigInPasswordVC") as? SigInPasswordVC else {return}
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                // 인증 실패
                print(error.debugDescription)
                self.errorLabel.isHidden = false
                self.errorLabel.text = "인증번호가 일치하지 않습니다."
            }
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension SigInPhoneNumberVC {
    func didSuccessSignInPhoneNumberExist(_ result: SignInPhoneNumberDuplicateResponse) {
        if(!isReAuth){//인증버튼이면
            phoneAuth(phoneNumber: currentNumber)
            print(result.message)
        }else{
            phoneReAuth(phoneNumber: currentNumber)
            print(result.message)
        }
    }
    
    func failedToRequestSignInPhoneNumberExist(message: String) {
        self.presentAlert(title: message)
    }
}
