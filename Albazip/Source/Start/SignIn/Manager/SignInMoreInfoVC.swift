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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalBgView.alpha = 0.0
        salaryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInSelectSalaryDateVC") as? SignInSelectSalaryDateVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            vc.salaryModalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
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
        modalBgView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        salaryTextField.text = data
    }
}
