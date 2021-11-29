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
        //https://bronzed-balaur-143.notion.site/42041221d1a6413f84542f571bee6b9c
        
        if let url = URL(string: "https://bronzed-balaur-143.notion.site/42041221d1a6413f84542f571bee6b9c") {
                    UIApplication.shared.open(url, options: [:])
                }
        /*
        let newStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "RegisterPermissionVC") as? RegisterPermissionVC else {return}
        nextVC.status = 0
        self.navigationController?.pushViewController(nextVC, animated: true)*/
    }
    
    @objc func privatePermissionTapped(sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://bronzed-balaur-143.notion.site/02e8b5a9cf514702977b4e01b82651ca") {
                    UIApplication.shared.open(url, options: [:])
                }
        /*
        let newStoryboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "RegisterPermissionVC") as? RegisterPermissionVC else {return}
        nextVC.status = 1
        self.navigationController?.pushViewController(nextVC, animated: true)*/
    }
}
