//
//  SettingUseTermVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
class SettingUseTermVC: UIViewController{
    @IBOutlet var usePermission: UIStackView!
    @IBOutlet var privatePermission: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(usePermissionTapped))
        usePermission.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(privatePermissionTapped))
        privatePermission.addGestureRecognizer(tapGestureRecognizer2)
    }
    @IBAction func btnCacel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func usePermissionTapped(sender: UITapGestureRecognizer) {
        let newStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "RegisterPermissionVC") as? RegisterPermissionVC else {return}
        nextVC.status = 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func privatePermissionTapped(sender: UITapGestureRecognizer) {
        let newStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "RegisterPermissionVC") as? RegisterPermissionVC else {return}
        nextVC.status = 1
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
