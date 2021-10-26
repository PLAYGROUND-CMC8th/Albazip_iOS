//
//  SignInWorkerCode.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import Foundation
import UIKit

class SignInWorkerCodeVC : UIViewController{
    
    
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        codeTextField.addLeftPadding()
        codeTextField.delegate = self
        self.dismissKeyboardWhenTappedAround()
    }
    func checkPassword(){
        if codeTextField.text!.count > 0{
            btnNext.isEnabled = true
            btnNext.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btnNext.setTitleColor(#colorLiteral(red: 0.203897506, green: 0.2039385736, blue: 0.2081941962, alpha: 1), for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = #colorLiteral(red: 0.9991410375, green: 0.9350907207, blue: 0.743348062, alpha: 1)
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    
}
extension SignInWorkerCodeVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        textField.borderColor = .mainYellow
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
