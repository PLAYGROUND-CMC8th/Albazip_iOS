//
//  SignInSelectPositionVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import Foundation
import UIKit
class SignInSelectPositionVC: UIViewController{
    
    
    @IBOutlet weak var managerView: UIView!
    @IBOutlet weak var workerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(managerViewTapped))
        managerView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(workerViewTapped))
        workerView.addGestureRecognizer(tapGestureRecognizer2)

        
    }
    @objc func managerViewTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "SignInManagerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "SignInSearchStoreVC") as? SignInSearchStoreVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func workerViewTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "SignInWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "SignInWorkerCodeVC") as? SignInWorkerCodeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignInSettingVC") as? SignInSettingVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
