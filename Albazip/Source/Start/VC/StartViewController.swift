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
        
        //내맘대로 바꾸깅
        /*
        UserDefaults.standard.set("",forKey: "token")
        print("token: \(UserDefaults.standard.string(forKey: "token")!)")
        UserDefaults.standard.set("",forKey: "job")
        print("job: \(UserDefaults.standard.string(forKey: "job")!)")
        
        */
       
        autoLogin()
        
    }
    
    func autoLogin(){
        // 자동 로그인
        if let token = UserDefaults.standard.string(forKey: "token"), let job = UserDefaults.standard.string(forKey: "job"){
            
            if job == "1"{ //관리자 페이지로
                let newStoryboard = UIStoryboard(name: "MainManager", bundle: nil)
                let newViewController = newStoryboard.instantiateViewController(identifier: "MainManagerTabBarController")
                self.changeRootViewController(newViewController)
            }else if job == "2"{ //근무자 페이지로
                let newStoryboard = UIStoryboard(name: "MainWorker", bundle: nil)
                let newViewController = newStoryboard.instantiateViewController(identifier: "MainWorkerTabBarController")
                self.changeRootViewController(newViewController)
            }
            
        }
        
        /*else{
            let storyboard = UIStoryboard(name: "RegisterStoryboard", bundle: Bundle.main)
            guard let nextVC = storyboard.instantiateViewController(identifier: "RegisterSelectPositionVC") as? RegisterSelectPositionVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }*/
    }
    @IBAction func btnResetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "LoginResetPhoneVC") as? LoginResetPhoneVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
