//
//  SigInBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class SigInBasicInfoVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
    }
    
}
