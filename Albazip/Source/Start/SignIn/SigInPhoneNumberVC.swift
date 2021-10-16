//
//  SigInPhoneNumberVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class SigInPhoneNumberVC: UIViewController{
    
    //MARK: - Outlet
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var checkNumberTextField: UITextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneNumberTextField.addLeftPadding()
        checkNumberTextField.addLeftPadding()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SigInPasswordVC") as? SigInPasswordVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
