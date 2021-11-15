//
//  HomeWorkerAlarmVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerAlarmVC: UIViewController{
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
