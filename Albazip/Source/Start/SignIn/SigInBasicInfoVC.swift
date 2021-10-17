//
//  SigInBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class SigInBasicInfoVC: UIViewController{
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameTextfield.delegate = self
        nameTextfield.delegate = self
        ageTextfield.delegate = self
        firstNameTextfield.addLeftPadding()
        nameTextfield.addLeftPadding()
        ageTextfield.addLeftPadding()
        self.dismissKeyboardWhenTappedAround()
        btnWoman.adjustsImageWhenHighlighted = false
        btnMan.adjustsImageWhenHighlighted = false
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInSelectPositionVC") as? SignInSelectPositionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func checkTextField(){
        if let text1 = firstNameTextfield.text, let text2 = nameTextfield.text, let text3 = ageTextfield.text, btnMan.isSelected || btnWoman.isSelected{
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .blurYellow
        }
    }
    @IBAction func btnMan(_ sender: Any) {
        btnMan.isSelected = true
        btnMan.backgroundColor = .semiYellow
        btnMan.borderColor = .mainYellow
        btnWoman.isSelected = false
        btnWoman.backgroundColor = .none
        btnWoman.borderColor = .blurGray
        checkTextField()
    }
    @IBAction func btnWoman(_ sender: Any) {
        btnWoman.isSelected = true
        btnWoman.backgroundColor = .semiYellow
        btnWoman.borderColor = .mainYellow
        btnMan.isSelected = false
        btnMan.backgroundColor = .none
        btnMan.borderColor = .blurGray
        checkTextField()
    }
    
    
}
extension SigInBasicInfoVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == firstNameTextfield){
            firstNameTextfield.borderColor = .mainYellow
            nameTextfield.borderColor = .blurGray
            ageTextfield.borderColor = .blurGray
        }else if(textField == nameTextfield){
            firstNameTextfield.borderColor = .blurGray
            nameTextfield.borderColor = .mainYellow
            ageTextfield.borderColor = .blurGray
        }else if(textField == ageTextfield){
            firstNameTextfield.borderColor = .blurGray
            nameTextfield.borderColor = .blurGray
            ageTextfield.borderColor = .mainYellow
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
