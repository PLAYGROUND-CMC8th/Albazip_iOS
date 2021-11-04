//
//  MyPageManagerAddWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import Foundation
import UIKit

class MyPageManagerAddWorkerVC: UIViewController{
 
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo1TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo3TableViewCell")
        //MyPageManagerWriteCommunityTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK:- Table View Data Source

extension MyPageManagerAddWorkerVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo1TableViewCell") as? MyPageManagerSelectInfo1TableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo2TableViewCell") as? MyPageManagerSelectInfo2TableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo3TableViewCell") as? MyPageManagerSelectInfo3TableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 397
        case 1:
            return 269
        case 2:
            return 208
        default:
            
        return 175
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
}
