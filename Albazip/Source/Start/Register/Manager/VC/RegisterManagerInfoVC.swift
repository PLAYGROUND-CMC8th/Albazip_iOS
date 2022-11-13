//
//  RegisterManagerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
import AnyFormatKit

class RegisterManagerInfoVC: UIViewController{
    
    
    @IBOutlet var registerNumberTextField: UITextField!
    @IBOutlet var errorLabel1: UILabel!
    @IBOutlet var checkImage1: UIImageView!
    @IBOutlet var btnNext: UIButton!
    
    // Datamanager
    lazy var dataManager1: RegisterNumberExistDataManager = RegisterNumberExistDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        registerNumberTextField.addLeftPadding()
        
        registerNumberTextField.delegate = self
        errorLabel1.isHidden = true
        registerNumberTextField.attributedPlaceholder = NSAttributedString(string: "사업자 등록번호 10자리 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.registerNumber = registerNumberTextField.text!
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterMoreInfoVC") as? RegisterMoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension RegisterManagerInfoVC: UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == registerNumberTextField){
            registerNumberTextField.borderColor = .mainYellow
            errorLabel1.isHidden = true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == registerNumberTextField){
            //사업자 등록 확인 api 호출
            if let text = registerNumberTextField.text{
                dataManager1.getRegisterNumberExist(vc: self, number: text)
            }
        }
        return true
    }
    // 사업자 인증번호 입력 포맷 설정 "###-##-#####"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }

        let formatter = DefaultTextInputFormatter(textPattern: "###-##-#####")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        
        if (textField.text?.count == 12){
            //사업자 등록 확인 api 호출
            if let text = registerNumberTextField.text{
                dataManager1.getRegisterNumberExist(vc: self, number: text)
            }
        }
        return false
    }
}

extension RegisterManagerInfoVC {
    func didSuccessRegisterNumberExist(_ result: RegisterNumberExistResponse) {
        if(result.message == "사업자등번호가 존재합니다."){
            checkImage1.image = #imageLiteral(resourceName: "icCheckedCorrect")
            registerNumberTextField.borderColor = .lightGray
            registerNumberTextField.isEnabled = false
            errorLabel1.isHidden = true
            
            btnNext.isEnabled = true
            btnNext.backgroundColor = .enableYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }else{
            errorLabel1.isHidden = false
            errorLabel1.text = result.message
            registerNumberTextField.borderColor = .red
            
            btnNext.isEnabled = false
            btnNext.backgroundColor = .disableYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        errorLabel1.isHidden = true
        
        btnNext.isEnabled = false
        btnNext.backgroundColor = .disableYellow
        btnNext.setTitleColor(.semiGray, for: .normal)
    }
}
