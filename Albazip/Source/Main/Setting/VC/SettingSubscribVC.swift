//
//  SettingSubscribVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
class SettingSubscribVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
