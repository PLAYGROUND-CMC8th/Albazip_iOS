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
        registerManagerInfo.ownerName = "김수빈" //TODO: 수빈
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterMoreInfoVC") as? RegisterMoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension RegisterManagerInfoVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == registerNumberTextField){
            registerNumberTextField.borderColor = .mainYellow
        }
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        if(textField == registerNumberTextField){
            //사업자 등록 확인 api 호출
            if let text = registerNumberTextField.text{
                dataManager1.getRegisterNumberExist(vc: self, number: text)
            }
            
        }
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
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
