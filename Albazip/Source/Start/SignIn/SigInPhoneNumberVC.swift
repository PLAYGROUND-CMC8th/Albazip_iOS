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
    
    var currentVerificationId = ""
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneNumberTextField.addLeftPadding()
        checkNumberTextField.addLeftPadding()
        
        phoneNumberTextField.delegate = self
        checkNumberTextField.delegate = self
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    @IBAction func btnAuth(_ sender: Any) {
        
        Auth.auth().accessibilityLanguage = "kr";
        
        if let phoneNumber = phoneNumberTextField.text{
            // Step 4: Request SMS
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }

                  // Either received APNs or user has passed the reCAPTCHA
                  // Step 5: Verification ID is saved for later use for verifying OTP with phone number
                  self.currentVerificationId = verificationID!
                }
        }
        
        //UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID:currentVerificationId,verificationCode: checkNumberTextField.text!)
        
        Auth.auth().signIn(with: credential){(success, error) in
            if error == nil{
                print(success ?? "")
                print("User Signed in...")
            }else{
                print(error.debugDescription)
            }
        }
        
        /*
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SigInPasswordVC") as? SigInPasswordVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
 */
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
            phoneNumberTextField.borderColor = .blurGray
            
        }else if(textField == phoneNumberTextField){
            checkNumberTextField.borderColor = .blurGray
            phoneNumberTextField.borderColor = .mainYellow
        }
        btnConfirm.isEnabled = true
        btnConfirm.setImage(#imageLiteral(resourceName: "btnActive"), for: .normal)
        btnNext.isEnabled = true
        btnNext.backgroundColor = .mainYellow
        btnNext.setTitleColor(.gray, for: .normal)
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .blurGray
    }
    
    
}

