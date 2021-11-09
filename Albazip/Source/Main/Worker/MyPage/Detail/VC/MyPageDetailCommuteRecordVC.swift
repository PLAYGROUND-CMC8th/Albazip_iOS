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
        setupTableView()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        //tableView.register(UINib(nibName: "MyPageDetailCommuteMonthTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCommuteMonthTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailCommuteRecordTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailCommuteRecordTableViewCell")
        //MyPageDetailCommuteRecordTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
//MARK:- Table View Data Source

extension MyPageDetailCommuteRecordVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCountTableViewCell") as? MyPageDetailCountTableViewCell {
                cell.selectionStyle = .none
                cell.titleLabel.text = "지각횟수"
                cell.countLabel.text = "0"
                cell.unitLabel.text = "회"
                print(indexPath.row)
                return cell
            }
        }else if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCommuteMonthTableViewCell") as? MyPageDetailCommuteMonthTableViewCell {
                cell.selectionStyle = .none
                
                print(indexPath.row)
                return cell
            }
        }*/
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCommuteRecordTableViewCell") as? MyPageDetailCommuteRecordTableViewCell {
                cell.selectionStyle = .none
                
                print(indexPath.row)
                return cell
            }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        /*
        if indexPath.row == 0{
            return 113
        }else if indexPath.row == 1{
            return 44
        }*/
            return 133
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
