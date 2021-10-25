//
//  SignInMoreInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
import UIKit

class SignInMoreInfoVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
    }
}
