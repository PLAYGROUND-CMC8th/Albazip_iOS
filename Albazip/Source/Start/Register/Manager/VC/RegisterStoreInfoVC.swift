//
//  RegisterStoreInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import UIKit

class RegisterStoreInfoVC: UIViewController{
  
    
    @IBOutlet var storeNameTextField: UITextField!
    @IBOutlet var storeTypeTextField: UITextField!
    @IBOutlet var storeLocationTextField: UITextField!
    @IBOutlet var storeLocationDetailTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var modalBgView: UIView!
    
    var storeName = ""
    var storeLocation = ""
    
    var selectedType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        if(storeName != "" && storeLocation != ""){
            storeNameTextField.text = storeName
            storeLocationTextField.text = storeLocation
            storeNameTextField.isEnabled = false
            storeLocationTextField.isEnabled = false
        }
    }
    
    func setUI() {
        storeNameTextField.addLeftPadding()
        storeTypeTextField.addLeftPadding()
        storeLocationTextField.addLeftPadding()
        storeLocationDetailTextField.addLeftPadding()
        self.dismissKeyboardWhenTappedAround()
        storeNameTextField.delegate = self
        storeLocationTextField.delegate = self
        storeLocationDetailTextField.delegate = self
        storeTypeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        modalBgView.alpha = 0.0
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectStoreTypeVC") as? RegisterSelectStoreTypeVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            vc.modalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    func checkTextField(){
        if storeNameTextField.text!.count > 0 , storeLocationTextField.text!.count > 0, storeLocationDetailTextField.text!.count > 0, selectedType{
            
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.name = storeNameTextField.text!
        registerManagerInfo.type = storeTypeTextField.text!
        registerManagerInfo.address = storeLocationTextField.text! + " " + storeLocationDetailTextField.text!
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterManagerInfoVC") as? RegisterManagerInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

extension RegisterStoreInfoVC: UITextFieldDelegate{
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == storeNameTextField){
            storeNameTextField.borderColor = .mainYellow
            storeLocationTextField.borderColor = .lightGray
            storeLocationDetailTextField.borderColor = .lightGray
        }else if(textField == storeLocationTextField){
            storeNameTextField.borderColor = .lightGray
            storeLocationTextField.borderColor = .mainYellow
            storeLocationDetailTextField.borderColor = .lightGray
        }else if(textField == storeLocationDetailTextField){
            storeNameTextField.borderColor = .lightGray
            storeLocationTextField.borderColor = .lightGray
            storeLocationDetailTextField.borderColor = .mainYellow
        }
        //checkTextField()
        
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

extension RegisterStoreInfoVC: ModalDelegate {
    
    func modalDismiss() {
        modalBgView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        storeTypeTextField.text = data
        selectedType = true
        checkTextField()
    }
}
