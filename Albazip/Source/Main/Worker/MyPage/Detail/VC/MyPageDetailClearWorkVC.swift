//
//  MyPageDetailClearWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import Foundation
import UIKit
class MyPageDetailClearWorkVC: UIViewController{
    
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
        
        let todayGoodsCellNib = UINib(nibName: "MyPageDetailClearWorkTableViewCell", bundle: nil)
        self.tableView.register(todayGoodsCellNib, forCellReuseIdentifier: "MyPageDetailClearWorkTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}
//MARK:- Table View Data Source

extension MyPageDetailClearWorkVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCountTableViewCell") as? MyPageDetailCountTableViewCell {
                cell.selectionStyle = .none
                cell.titleLabel.text = "업무완수율"
                cell.countLabel.text = "100"
                cell.unitLabel.text = "%"
                print(indexPath.row)
                return cell
            }
        }*/
 
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkTableViewCell") as? MyPageDetailClearWorkTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        /*
        if indexPath.row == 0{
            return 113
        }else{*/
            return 125
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
