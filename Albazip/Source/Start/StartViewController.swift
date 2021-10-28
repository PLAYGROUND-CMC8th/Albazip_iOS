//
//  StartViewController.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit

class StartViewController: UIViewController{
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        autoLogin()
        
    }
    
    func autoLogin(){
        // 자동 로그인
        if let token = UserDefaults.standard.string(forKey: "token"){
            let storyboard = UIStoryboard(name: "SignInStoryboard", bundle: Bundle.main)
            guard let nextVC = storyboard.instantiateViewController(identifier: "SignInSelectPositionVC") as? SignInSelectPositionVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    @IBAction func btnResetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "LoginResetPhoneVC") as? LoginResetPhoneVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
