//
//  SettingMyInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
import UIKit

class SettingMyInfoVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditInfo(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingEditBasicInfoVC") as? SettingEditBasicInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnEditPhone(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingEditPhoneNumberVC") as? SettingEditPhoneNumberVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
