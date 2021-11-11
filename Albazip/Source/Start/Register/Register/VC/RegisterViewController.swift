//
//  RegisterViewController.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var btnAllAgree: UIButton!
    @IBOutlet weak var btnAgree1: UIButton!
    @IBOutlet weak var btnAgree2: UIButton!
    @IBOutlet weak var btnAgree3: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var isAllChecked = false
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAllAgree(_ sender: Any) {
        btnAllAgree.isSelected.toggle()
        if(btnAllAgree.isSelected){
            btnAgree1.isSelected = true
            btnAgree2.isSelected = true
            btnAgree3.isSelected = true
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }else{
            btnAgree1.isSelected = false
            btnAgree2.isSelected = false
            btnAgree3.isSelected = false
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
    
    @IBAction func btnAgree1(_ sender: Any) {
        btnAgree1.isSelected.toggle()
        if(!btnAgree1.isSelected){
            btnAllAgree.isSelected = false
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }else if(btnAgree1.isSelected && btnAgree2.isSelected && btnAgree3.isSelected){
            btnAllAgree.isSelected = true
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func btnAgree2(_ sender: Any) {
        btnAgree2.isSelected.toggle()
        if(!btnAgree2.isSelected){
            btnAllAgree.isSelected = false
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }else if(btnAgree1.isSelected && btnAgree2.isSelected && btnAgree3.isSelected){
            btnAllAgree.isSelected = true
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func btnAgree3(_ sender: Any) {
        btnAgree3.isSelected.toggle()
        if(!btnAgree3.isSelected){
            btnAllAgree.isSelected = false
            btnNext.isEnabled = false
            btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }else if(btnAgree1.isSelected && btnAgree2.isSelected && btnAgree3.isSelected){
            btnAllAgree.isSelected = true
            btnNext.isEnabled = true
            btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterPhoneNumberVC") as? RegisterPhoneNumberVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
