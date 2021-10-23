//
//  SigInBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class SigInBasicInfoVC: UIViewController, ModalViewControllerDelegate{
    
    // 모달뷰 값 전달 받기
    func modalDidFinished(modalText: String) {
        print(modalText)
        btnAge.setTitle("   "+modalText, for: .normal)
        btnAge.setTitleColor(#colorLiteral(red: 0.1990817189, green: 0.2041014135, blue: 0.2039682269, alpha: 1), for: .normal)
        selectAge = true
    }
    
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet var btnAge: UIButton!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var selectAge = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        //self.modalView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let viewController : SignInSelectYearVC = segue.destination as! SignInSelectYearVC
            viewController.delegate = self
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
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInSelectPositionVC") as? SignInSelectPositionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
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
    
    @IBAction func btnYear(_ sender: Any) {
        self.nameTextfield.resignFirstResponder()
        goAlertView()
    }
    
    func goAlertView()  {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInSelectYearVC") as? SignInSelectYearVC else {return}
                
        //nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .overCurrentContext
                
        self.present(nextVC, animated: false, completion: nil)
    }
    
}
extension SigInBasicInfoVC: UITextFieldDelegate{
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == firstNameTextfield){
            firstNameTextfield.borderColor = .mainYellow
            nameTextfield.borderColor = .blurGray
            
        }else if(textField == nameTextfield){
            firstNameTextfield.borderColor = .blurGray
            nameTextfield.borderColor = .mainYellow
            
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
