//
//  SettingWithdrawVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
class SettingWithdrawVC: UIViewController{
    lazy var datamanager: SettingWithdrawDatamanager = SettingWithdrawDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCancel2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnYes(_ sender: Any) {
        showIndicator()
        datamanager.getSettingWithdraw(vc: self)
    }
    
}
extension SettingWithdrawVC {
    func didSuccessSettingWithdraw(result: SettingWithdrawResponse) {
    
        dismissIndicator()
        //탈퇴 성공 시 토큰 삭제, job 정보 삭제, startviewcontroller로 돌아가기,
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "job")
        let newStoryboard = UIStoryboard(name: "StartStoryboard", bundle: nil)
                let newViewController = newStoryboard.instantiateViewController(identifier: "StartNavigationViewController")
                self.changeRootViewController(newViewController)
    }
    
    func failedToRequestSettingWithdraw(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

