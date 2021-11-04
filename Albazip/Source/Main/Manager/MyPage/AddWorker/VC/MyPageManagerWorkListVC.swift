//
//  MyPageManagerWorkListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/05.
//

import Foundation
import UIKit

class MyPageManagerWorkListVC: UIViewController{
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
    }
    //MARK:- View Setup
    func setUI(){
        self.tabBarController?.tabBar.isHidden = true
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerWorkList1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList1TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList3TableViewCell")
        //MyPageManagerWriteCommunityTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btnNext: UIView!
    
}

//MARK:- Table View Data Source

extension  MyPageManagerWorkListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList1TableViewCell") as? MyPageManagerWorkList1TableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList2TableViewCell") as? MyPageManagerWorkList2TableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList3TableViewCell") as? MyPageManagerWorkList3TableViewCell {
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
            return 143
        case 1:
            return 110
        case 2:
            return 60
        default:
            
        return 175
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
}
