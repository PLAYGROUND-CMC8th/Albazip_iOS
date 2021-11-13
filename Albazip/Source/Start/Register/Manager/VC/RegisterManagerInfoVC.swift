//
//  RegisterManagerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
class RegisterManagerInfoVC: UIViewController{
    
    
    @IBOutlet var registerNumberTextField: UITextField!
    @IBOutlet var errorLabel1: UILabel!
    @IBOutlet var personNameTextField: UITextField!
    @IBOutlet var errorLabel2: UILabel!
    @IBOutlet var checkImage1: UIImageView!
    @IBOutlet var checkImage2: UIImageView!
    @IBOutlet var btnNext: UIButton!
    
    // Datamanager
    lazy var dataManager1: RegisterNumberExistDataManager = RegisterNumberExistDataManager()
    lazy var dataManager2: RegisterNumberMatchDataManager = RegisterNumberMatchDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        registerNumberTextField.addLeftPadding()
        personNameTextField.addLeftPadding()
        registerNumberTextField.delegate = self
        personNameTextField.delegate = self
        errorLabel1.isHidden = true
        errorLabel2.isHidden = true
        checkImage2.isHidden = true
        personNameTextField.isHidden = true
        registerNumberTextField.attributedPlaceholder = NSAttributedString(string: "사업자 등록번호 10자리 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        personNameTextField.attributedPlaceholder = NSAttributedString(string: "대표자명 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        self.dismissKeyboardWhenTappedAround()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.registerNumber = registerNumberTextField.text!
        registerManagerInfo.ownerName = personNameTextField.text!
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterMoreInfoVC") as? RegisterMoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension RegisterManagerInfoVC: UITextFieldDelegate{
    
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
        if(textField == registerNumberTextField){
            //사업자 등록 확인 api 호출
            if let text = registerNumberTextField.text{
                dataManager1.getRegisterNumberExist(vc: self, number: text)
            }
            
        }else if(textField == personNameTextField){
            // 대표자명 인증 api 호출
            if let text = personNameTextField.text{
                print(text)
                print(registerNumberTextField.text!)
                dataManager2.getRegisterNumberMatch(vc: self, number: registerNumberTextField.text!, name: text)
            }
            
        }
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        //checkPassword()
        
        if(textField == registerNumberTextField){
            //사업자 등록 확인 api 호출
            if let text = registerNumberTextField.text{
                dataManager1.getRegisterNumberExist(vc: self, number: text)
            }
            
        }else if(textField == personNameTextField){
            // 대표자명 인증 api 호출
            if let text = personNameTextField.text{
                print(text)
                print(registerNumberTextField.text!)
                dataManager2.getRegisterNumberMatch(vc: self, number: registerNumberTextField.text!, name: text)
            }
            
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //checkPassword()
        return true
    }
}

extension RegisterManagerInfoVC {
    func didSuccessRegisterNumberExist(_ result: RegisterNumberExistResponse) {
        if(result.message == "사업자등번호가 존재합니다."){
            //self.presentAlert(title: result.message)
            personNameTextField.isHidden = false
            checkImage1.image = #imageLiteral(resourceName: "icCheckedCorrect")
            registerNumberTextField.borderColor = .lightGray
            registerNumberTextField.isEnabled = false
            checkImage2.isHidden = false
            errorLabel1.isHidden = true
        }else{
            errorLabel1.isHidden = false
            errorLabel1.text = result.message
            registerNumberTextField.borderColor = .red
        }
        //self.presentAlert(title: result.message)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        errorLabel1.isHidden = true
        //errorLabel1.text = message
    }
    
    func didSuccessRegisterNumberMatch(_ result: RegisterNumberMatchResponse) {
        if(result.message == "사업자등번호가 인증되었습니다."){
            //self.presentAlert(title: result.message)
            checkImage2.image = #imageLiteral(resourceName: "icCheckedCorrect")
            errorLabel2.isHidden = true
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
            personNameTextField.borderColor = .lightGray
        }else{
            errorLabel2.isHidden = false
            errorLabel2.text = result.message
            checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
            personNameTextField.borderColor = .red
        }
        //self.presentAlert(title: result.message)
    }
    
    func failedToRequestMatch(message: String) {
        self.presentAlert(title: message)
        errorLabel2.isHidden = true
        checkImage2.image = #imageLiteral(resourceName: "icCheckedNormal")
        btnNext.isEnabled = false
        btnNext.backgroundColor = .semiYellow
        btnNext.setTitleColor(.semiGray, for: .normal)
        //errorLabel1.text = message
    }
}
