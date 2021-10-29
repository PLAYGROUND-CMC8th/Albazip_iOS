//
//  SignInSettingVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/18.
//

import UIKit

class SignInSettingVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
