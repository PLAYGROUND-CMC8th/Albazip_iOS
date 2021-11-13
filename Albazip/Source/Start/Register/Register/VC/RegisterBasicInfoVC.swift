//
//  RegisterBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class RegisterBasicInfoVC: UIViewController{
    
   
    @IBOutlet var modalBgView: UIView!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var ageTextfield: UITextField!
    
    var selectAge = false
    
    // Datamanager
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        //self.modalView.delegate = self
        modalBgView.alpha = 0.0
        ageTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        
        firstNameTextfield.attributedPlaceholder = NSAttributedString(string: "성", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        ageTextfield.attributedPlaceholder = NSAttributedString(string: "출생년도 (YYYY)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectYearVC") as? RegisterSelectYearVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    func setUI(){
        firstNameTextfield.delegate = self
        nameTextfield.delegate = self
        
        firstNameTextfield.addLeftPadding()
        nameTextfield.addLeftPadding()
        
        self.dismissKeyboardWhenTappedAround()
        btnWoman.adjustsImageWhenHighlighted = false
        btnMan.adjustsImageWhenHighlighted = false
        ageTextfield.addLeftPadding()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        let registerBasicInfo = RegisterBasicInfo.shared
        var gender = "M"
        if btnWoman.isSelected{
            gender = "F"
        }
        let input = RegisterRequest(phone: registerBasicInfo.phone!, pwd: registerBasicInfo.pwd!, lastName: firstNameTextfield.text!, firstName: nameTextfield.text!,birthyear: ageTextfield.text!, gender: gender)
        
        print(input)
        
        dataManager.postRegister(input, delegate: self)
        
    }
    
    func checkTextField(){
        if firstNameTextfield.text!.count > 0 , nameTextfield.text!.count > 0, selectAge{
            if(btnMan.isSelected || btnWoman.isSelected){
                btnNext.isEnabled = true
                btnNext.backgroundColor = .mainYellow
                btnNext.setTitleColor(.gray, for: .normal)
            }
            
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
    @IBAction func btnMan(_ sender: Any) {
        
        btnMan.isSelected = true
        btnMan.backgroundColor = .semiYellow
        btnMan.borderColor = .mainYellow
        btnWoman.isSelected = false
        btnWoman.backgroundColor = .none
        btnWoman.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        checkTextField()
    }
    @IBAction func btnWoman(_ sender: Any) {
        
        btnWoman.isSelected = true
        btnWoman.backgroundColor = .semiYellow
        btnWoman.borderColor = .mainYellow
        btnMan.isSelected = false
        btnMan.backgroundColor = .none
        btnMan.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        checkTextField()
    }

}

extension RegisterBasicInfoVC {
    func didSuccessRegister(_ result: RegisterResponse) {
        //self.presentAlert(title: "회원 가입에 성공하였습니다", message: result.message)
        //UserDefaults.standard.set(result.data?.token,forKey: "token")
        let data = RegisterBasicInfo.shared
        data.token = result.data?.token.token
        // 이름 정보 저장
        data.firstName = nameTextfield.text
        //print("token: \(UserDefaults.standard.string(forKey: "token")!)")
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterSelectPositionVC") as? RegisterSelectPositionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension RegisterBasicInfoVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == firstNameTextfield){
            firstNameTextfield.borderColor = .mainYellow
            nameTextfield.borderColor = .lightGray
            
        }else if(textField == nameTextfield){
            firstNameTextfield.borderColor = .lightGray
            nameTextfield.borderColor = .mainYellow
            
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
extension RegisterBasicInfoVC: YearModalDelegate {
    
    func modalDismiss() {
        modalBgView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        ageTextfield.text = data
        selectAge = true
        checkTextField()
    }
}
