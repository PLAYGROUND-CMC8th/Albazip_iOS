//
//  RegisterWorkerCode.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import Foundation
import UIKit

class RegisterWorkerCodeVC : UIViewController{
    
    
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    // Datamanager
    lazy var dataManager: RegisterWorkerDataManager = RegisterWorkerDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        codeTextField.addLeftPadding()
        codeTextField.delegate = self
        errorLabel.isHidden = true
        codeTextField.attributedPlaceholder = NSAttributedString(string: "코드 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        self.dismissKeyboardWhenTappedAround()
    }
    func checkCode(){
        if codeTextField.text!.count > 0{
            btnNext.isEnabled = true
            btnNext.backgroundColor = .enableYellow
            btnNext.setTitleColor(#colorLiteral(red: 0.203897506, green: 0.2039385736, blue: 0.2081941962, alpha: 1), for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .disableYellow
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if codeTextField.text!.count > 0{
            showIndicator()
            dataManager.postRegisterWorker(RegisterWorkerRequset(code: codeTextField.text!), delegate: self)
        }
    }
    
}
extension RegisterWorkerCodeVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        textField.borderColor = .mainYellow
        checkCode()
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        checkCode()
        
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        checkCode()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkCode()
        return true
    }
}

extension RegisterWorkerCodeVC{
    func didSuccessRegisterWorker(_ result: RegisterWorkerResponse) {
        dismissIndicator()
        if(result.message == "성공적으로 근무자 가입이 완료되었습니다."){
            errorLabel.isHidden = true
            codeTextField.borderColor = .lightGray
            //우선 유저 토큰 로컬에 저장
            UserDefaults.standard.set(result.data?.token ,forKey: "token")
            print("token: \(UserDefaults.standard.string(forKey: "token")!)")
            UserDefaults.standard.set(2 ,forKey: "job")
            print("job: \(UserDefaults.standard.string(forKey: "job")!)")
            //온보딩 화면으로 넘어가기
            let newStoryboard = UIStoryboard(name: "OnboardingWorkerStoryboard", bundle: nil)
                    let newViewController = newStoryboard.instantiateViewController(identifier: "OnboardingWorkerVC")
                    self.changeRootViewController(newViewController)
            
        }else{
            errorLabel.isHidden = false
            codeTextField.borderColor = .red
            //self.presentAlert(title: result.message)
        }
        //self.presentAlert(title: result.message)
    }
    
    func failedToRegisterWorker(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)
        codeTextField.borderColor = .lightGray
        errorLabel.isHidden = true
    }
}
