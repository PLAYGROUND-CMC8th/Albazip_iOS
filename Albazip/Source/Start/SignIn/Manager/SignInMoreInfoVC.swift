//
//  SignInMoreInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
import UIKit

class SignInMoreInfoVC: UIViewController {
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var btnNoBreak: UIButton!
    @IBOutlet var btnMon: UIButton!
    @IBOutlet var btnTue: UIButton!
    @IBOutlet var btnWed: UIButton!
    @IBOutlet var btnThu: UIButton!
    @IBOutlet var btnFri: UIButton!
    @IBOutlet var btnSat: UIButton!
    @IBOutlet var btnSun: UIButton!
    @IBOutlet var btnBreak: UIButton!
    
    @IBOutlet var startTextField: UITextField!
    @IBOutlet var endTextField: UITextField!
    
    @IBOutlet var salaryTextField: UITextField!
    @IBOutlet var hourLabel: UILabel!
    
    //버튼 선택 정보 저장
    var btnArray = [false, false, false, false, false, false,false, false, false]
    // Datamanager
    lazy var dataManager: SignInManagerDataManager = SignInManagerDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        salaryTextField.addRightPadding()
        modalBgView.isHidden = true
        salaryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        startTextField.addLeftPadding()
        endTextField.addLeftPadding()
        startTextField.delegate = self
        endTextField.delegate = self
        
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInSelectSalaryDateVC") as? SignInSelectSalaryDateVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.isHidden = false
            vc.salaryModalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
            
    }
    
    @IBAction func btnNoBreak(_ sender: Any) {
        btnNoBreak.isSelected.toggle()
        if(btnNoBreak.isSelected){
            print("1")
            disableBtn(btn: btnMon)
            disableBtn(btn: btnTue)
            disableBtn(btn: btnWed)
            disableBtn(btn: btnThu)
            disableBtn(btn: btnFri)
            disableBtn(btn: btnSat)
            disableBtn(btn: btnSun)
            disableBtn(btn: btnBreak)
            selectedBtn(btn: btnNoBreak)
        }else{
            print("2")
            enableBtn(btn: btnMon)
            enableBtn(btn: btnTue)
            enableBtn(btn: btnWed)
            enableBtn(btn: btnThu)
            enableBtn(btn: btnFri)
            enableBtn(btn: btnSat)
            enableBtn(btn: btnSun)
            enableBtn(btn: btnBreak)
            enableBtn(btn: btnNoBreak)
        }
    }
    @IBAction func btnMon(_ sender: Any) {
        btnMon.isSelected.toggle()
        if(btnMon.isSelected){
            selectedBtn(btn: btnMon)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnMon)
            checkBtn()
        }
    }
    @IBAction func btnTue(_ sender: Any) {
        btnTue.isSelected.toggle()
        if(btnTue.isSelected){
            selectedBtn(btn: btnTue)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnTue)
            checkBtn()
        }
    }
    @IBAction func btnWed(_ sender: Any) {
        btnWed.isSelected.toggle()
        if(btnWed.isSelected){
            selectedBtn(btn: btnWed)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnWed)
            checkBtn()
        }
    }
    @IBAction func btnThu(_ sender: Any) {
        btnThu.isSelected.toggle()
        if(btnThu.isSelected){
            selectedBtn(btn: btnThu)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnThu)
            checkBtn()
        }
    }
    @IBAction func btnFri(_ sender: Any) {
        btnFri.isSelected.toggle()
        if(btnFri.isSelected){
            selectedBtn(btn: btnFri)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnFri)
            checkBtn()
        }
    }
    @IBAction func btnSat(_ sender: Any) {
        btnSat.isSelected.toggle()
        if(btnSat.isSelected){
            selectedBtn(btn: btnSat)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnSat)
            checkBtn()
        }
    }
    @IBAction func btnSun(_ sender: Any) {
        btnSun.isSelected.toggle()
        if(btnSun.isSelected){
            selectedBtn(btn: btnSun)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnSun)
            checkBtn()
        }
    }
    @IBAction func btnBreak(_ sender: Any) {
        btnBreak.isSelected.toggle()
        if(btnBreak.isSelected){
            selectedBtn(btn: btnBreak)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnBreak)
            checkBtn()
        }
    }
    
    
    func selectedBtn(btn: UIButton){
        btn.isEnabled = true
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
        btn.isSelected = true
    }
    
    func enableBtn(btn: UIButton){
        btn.isEnabled = true
        btn.backgroundColor = .none
        btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
        btn.isSelected = false
    }
    
    func disableBtn(btn: UIButton){
        btn.isEnabled = false
        btn.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
        btn.isSelected = false
    }
    
    func checkBtn(){
        if !btnMon.isSelected, !btnTue.isSelected, !btnWed.isSelected, !btnThu.isSelected, !btnFri.isSelected, !btnSat.isSelected, !btnSun.isSelected, !btnBreak.isSelected{
            enableBtn(btn: btnNoBreak)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
    }
}
extension SignInMoreInfoVC: SalaryModalDelegate {
    
    func modalDismiss() {
        modalBgView.isHidden = true
    }
    
    func textFieldData(data: String) {
        salaryTextField.text = data
    }
}

extension SignInMoreInfoVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(textField == startTextField || textField == endTextField){
                let newLength = (textField.text?.count)! + string.count - range.length
                    return !(newLength > 4)
            }
            
            return true
        }
}

extension SignInMoreInfoVC {
    func didSuccessSignInManager(_ result: SignInManagerResponse) {
        if(result.message == "성공적으로 관리자 가입이 완료되었습니다."){
            let newStoryboard = UIStoryboard(name: "OnboardingManagerStoryboard", bundle: nil)
                    let newViewController = newStoryboard.instantiateViewController(identifier: "OnboardingManagerVC")
                    self.changeRootViewController(newViewController)
        }else{
            self.presentAlert(title: result.message)
        }
    }
    
    func failedToSignInManager(message: String) {
        self.presentAlert(title: message)
    }
}
