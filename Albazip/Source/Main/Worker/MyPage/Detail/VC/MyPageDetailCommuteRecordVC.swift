//
//  MyPageDetailCommuteRecordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import Foundation
import UIKit

class MyPageDetailCommuteRecordVC: UIViewController{
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
