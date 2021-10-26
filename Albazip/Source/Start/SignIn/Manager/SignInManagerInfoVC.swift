//
//  SignInManagerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
class SignInManagerInfoVC: UIViewController{
    
    
    @IBOutlet var registerNumberTextField: UITextField!
    @IBOutlet var errorLabel1: UILabel!
    @IBOutlet var personNameTextField: UITextField!
    @IBOutlet var errorLabel2: UILabel!
    @IBOutlet var checkImage1: UIImageView!
    @IBOutlet var checkImage2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUI(){
        registerNumberTextField.addLeftPadding()
        personNameTextField.addLeftPadding()
        registerNumberTextField.delegate = self
        personNameTextField.delegate = self
        errorLabel1.isHidden = true
        errorLabel2.isHidden = true
        self.dismissKeyboardWhenTappedAround()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInMoreInfoVC") as? SignInMoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension SignInManagerInfoVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == registerNumberTextField){
            registerNumberTextField.borderColor = .mainYellow
            personNameTextField.borderColor = .lightGray
            
        }else if(textField == personNameTextField){
            registerNumberTextField.borderColor = .lightGray
            personNameTextField.borderColor = .mainYellow
        }
        //checkPassword()
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        //checkPassword()
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        //checkPassword()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //checkPassword()
        return true
    }
}
