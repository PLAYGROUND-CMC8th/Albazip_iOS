//
//  SettingLogoutVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

protocol SettingLogoutDelegate{
    func modalDismiss()
    func logout()
}

import Foundation
class SettingLogoutVC: UIViewController{
    var delegate: SettingLogoutDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.delegate?.modalDismiss()
        self.delegate?.logout()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
}
