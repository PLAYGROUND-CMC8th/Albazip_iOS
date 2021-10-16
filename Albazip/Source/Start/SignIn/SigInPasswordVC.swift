//
//  SigInPasswordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import Foundation
import UIKit
class SigInPasswordVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnNext(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SigInBasicInfoVC") as? SigInBasicInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
