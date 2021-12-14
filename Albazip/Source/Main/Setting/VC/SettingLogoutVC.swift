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
    @IBOutlet var backgroundView: UIView!
    var delegate: SettingLogoutDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.delegate?.modalDismiss()
        //self.delegate?.logout()
        //self.dismiss(animated: true, completion: nil)
        
        //로그아웃 시 토큰 삭제, job 정보 삭제, startviewcontroller로 돌아가기,
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "job")
        let newStoryboard = UIStoryboard(name: "StartStoryboard", bundle: nil)
                let newViewController = newStoryboard.instantiateViewController(identifier: "StartNavigationViewController")
                self.changeRootViewController(newViewController)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        self.delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
}
