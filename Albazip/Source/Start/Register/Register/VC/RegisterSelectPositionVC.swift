//
//  RegisterSelectPositionVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import Foundation
import UIKit
class RegisterSelectPositionVC: UIViewController{
    
    
    @IBOutlet weak var managerView: UIView!
    @IBOutlet weak var workerView: UIView!
    
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firebase.Log.signupSelectPosition.event()
        
        let data = RegisterBasicInfo.shared
        nameLabel.text = "\(data.firstName!)님 반가워요 :)\n포지션을 선택해주세요!"
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(managerViewTapped))
        managerView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(workerViewTapped))
        workerView.addGestureRecognizer(tapGestureRecognizer2)
        
        
    }
    @objc func managerViewTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "RegisterSearchStoreVC") as? RegisterSearchStoreVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func workerViewTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "RegisterWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "RegisterWorkerCodeVC") as? RegisterWorkerCodeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        let newStoryboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "SettingWorkerVC") as? SettingWorkerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
