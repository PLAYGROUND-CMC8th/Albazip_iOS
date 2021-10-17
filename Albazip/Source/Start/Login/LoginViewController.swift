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
            
        }else{
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = .blurYellow
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let newStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = newStoryboard.instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(newViewController)
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
            passwordTextfield.borderColor = .blurGray
            
        }else if(textField == passwordTextfield){
            phoneTextfield.borderColor = .blurGray
            passwordTextfield.borderColor = .mainYellow
            
        }
        checkTextField()
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .blurGray
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
