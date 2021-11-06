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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
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
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterSettingVC") as? RegisterSettingVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
