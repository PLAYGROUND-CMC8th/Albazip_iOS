//
//  SettingEditBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
class SettingEditBasicInfoVC: UIViewController{
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var ageTextfield: UITextField!
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var btnWoman: UIButton!
    @IBOutlet var btnMan: UIButton!
    @IBOutlet var btnNext: UIButton!
    
    //이전 뷰에서 받아올 값
    var userFirstName = ""
    var userName = ""
    var userAge = ""
    var userGender = -1
    
    var selectAge = true
    // Datamanager
    lazy var dataManager: SettingEditBasicInfoDatamanager = SettingEditBasicInfoDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        //self.modalView.delegate = self
        modalBgView.alpha = 0.0
        ageTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        
        firstNameTextfield.attributedPlaceholder = NSAttributedString(string: "성", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        ageTextfield.attributedPlaceholder = NSAttributedString(string: "출생년도 (YYYY)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        let newStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectYearVC") as? RegisterSelectYearVC {
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
        
        if userGender == 0{ // 남자
            btnMan.isSelected = true
            btnMan.backgroundColor = .semiYellow
            btnMan.borderColor = .mainYellow
            btnWoman.isSelected = false
            btnWoman.backgroundColor = .none
            btnWoman.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btnWoman.isSelected = true
            btnWoman.backgroundColor = .semiYellow
            btnWoman.borderColor = .mainYellow
            btnMan.isSelected = false
            btnMan.backgroundColor = .none
            btnMan.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }
        
        ageTextfield.text = userAge
        firstNameTextfield.text = userFirstName
        nameTextfield.text = userName
        
        //처음엔 버튼 활성화
        btnNext.isEnabled = true
        btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
    }
    func checkTextField(){
        if firstNameTextfield.text!.count > 0 , nameTextfield.text!.count > 0, selectAge{
            if(btnMan.isSelected || btnWoman.isSelected){
                btnNext.isEnabled = true
                
                btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
            }
            
        }else{
            btnNext.isEnabled = false
            
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func btnNext(_ sender: Any) {
        var gender = "0"
        if btnWoman.isSelected{
            gender = "1"
        }
        let input = SettingEditBasicInfoRequest(firstName: nameTextfield.text!, lastName: firstNameTextfield.text!, birthyear: ageTextfield.text!, gender: gender )
        showIndicator()
        dataManager.postSettingEditBasicInfo(input, delegate: self)
    }
    
}
extension SettingEditBasicInfoVC {
    func didSuccessSettingEditBasicInfo(result:  SettingEditBasicInfoResponse) {
        
        
        print(result.message!)
        
        dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequestSettingEditBasicInfo(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

extension SettingEditBasicInfoVC: UITextFieldDelegate{
    
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
extension SettingEditBasicInfoVC: YearModalDelegate {
    
    func modalDismiss() {
        modalBgView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        ageTextfield.text = data
        selectAge = true
        checkTextField()
    }
}
