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
    }
    
   
    @IBAction func btnResetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "LoginResetPhoneVC") as? LoginResetPhoneVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
