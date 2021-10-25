//
//  SignInManagerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
class SignInManagerInfoVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInMoreInfoVC") as? SignInMoreInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
