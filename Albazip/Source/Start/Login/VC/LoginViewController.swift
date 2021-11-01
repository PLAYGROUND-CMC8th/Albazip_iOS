//
//  LoginViewController.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    // Datamanager
    lazy var dataManager: LoginDataManager = LoginDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){
        phoneTextfield.addLeftPadding()
        passwordTextfield.addLeftPadding()
        phoneTextfield.delegate = self
        passwordTextfield.delegate = self
        self.dismissKeyboardWhenTappedAround()
        
    }
    func checkTextField(){
        if phoneTextfield.text!.count > 0 , passwordTextfield.text!.count > 0{
            btnLogin.isEnabled = true
            btnLogin.backgroundColor = .mainYellow
            btnLogin.setTitleColor(.gray, for: .normal)
        }else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = .semiYellow
            btnLogin.setTitleColor(.semiGray, for: .normal)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if let phone = phoneTextfield.text, let pwd = passwordTextfield.text{
            let input = LoginRequest(phone: phone, pwd: pwd)
            dataManager.postLogin(input, delegate: self)
        }
    }
    
    @IBAction func btnResetPassword(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "LoginResetPhoneVC") as? LoginResetPhoneVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == phoneTextfield){
            phoneTextfield.borderColor = .mainYellow
            passwordTextfield.borderColor = .lightGray
            
        }else if(textField == passwordTextfield){
            phoneTextfield.borderColor = .lightGray
            passwordTextfield.borderColor = .mainYellow
            
        }
        checkTextField()
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        checkTextField()
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        checkTextField()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        checkTextField()
        return true
    }
}

extension LoginViewController {
    func didSuccessLogin(_ result: LoginResponse) {
        //MARK: 사장님인지 근무자인지 판단해서 다른 스토리보드로 이동해야 할듯!
        
        //우선 유저 토큰 로컬에 저장
        UserDefaults.standard.set(result.data?.token.token,forKey: "token")
        print("token: \(UserDefaults.standard.string(forKey: "token")!)")
        
        //포지션 정보 있으면 모든 가입절차 완료한 사람임 -> Main 화면으로
        // 이때 근무자인지 관리자인지에 따라 다른 화면 보여줘야함. 우선 관리자만 해놨음
        if let position = result.data?.positionInfo{
            let newStoryboard = UIStoryboard(name: "MainManager", bundle: nil)
            let newViewController = newStoryboard.instantiateViewController(identifier: "MainManagerTabBarController")
            self.changeRootViewController(newViewController)
        }
        //포지션 정보 없으면 포지션 선택 안한것, 포지션 선택 페이지로!
        else{
            let newStoryboard = UIStoryboard(name: "SignInStoryboard", bundle: nil)
            let newViewController = newStoryboard.instantiateViewController(identifier: "SignInNavigationSelectPositionVC")
            self.changeRootViewController(newViewController)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
