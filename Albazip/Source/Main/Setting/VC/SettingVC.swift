//
//  SettingVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
import UIKit
class SettingVC : UIViewController, SettingLogoutDelegate{

    
    
    @IBOutlet var modalBgView: UIView!
    
    @IBOutlet var subscribView: UIButton!
    @IBOutlet var alarmView: UIStackView!
    @IBOutlet var myInfoView: UIStackView!
    @IBOutlet var noticeView: UIStackView!
    @IBOutlet var useTermView: UIStackView!
    @IBOutlet var versionView: UIStackView!
    @IBOutlet var logoutView: UIStackView!
    @IBOutlet var withdrawView: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGesture()
        modalBgView.isHidden = true
    }
    
    func setTapGesture()  {
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(subscribViewTapped))
        subscribView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(alarmViewTapped))
        alarmView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(myInfoViewTapped))
        myInfoView.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(noticeViewTapped))
        noticeView.addGestureRecognizer(tapGestureRecognizer4)
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(useTermViewTapped))
        useTermView.addGestureRecognizer(tapGestureRecognizer5)
        
       
        
        let tapGestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(logoutViewTapped))
        logoutView.addGestureRecognizer(tapGestureRecognizer7)
        
        let tapGestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(withdrawViewTapped))
        withdrawView.addGestureRecognizer(tapGestureRecognizer8)
    }
    
    @objc func subscribViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingSubscribVC") as? SettingSubscribVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func alarmViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingAlarmVC") as? SettingAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func noticeViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingNoticeVC") as? SettingNoticeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func useTermViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingUseTermVC") as? SettingUseTermVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func myInfoViewTapped(sender: UITapGestureRecognizer) {
     
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingMyInfoVC") as? SettingMyInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func logoutViewTapped(sender: UITapGestureRecognizer) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingLogoutVC") as? SettingLogoutVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.isHidden = false
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    @objc func withdrawViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingWithdrawVC") as? SettingWithdrawVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func modalDismiss() {
        modalBgView.isHidden = true
    }
    
    func logout() {
        showMessage(message: "로그아웃", controller: self)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
