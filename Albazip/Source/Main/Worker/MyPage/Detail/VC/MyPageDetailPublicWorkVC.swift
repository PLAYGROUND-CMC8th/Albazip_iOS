//
//  MyPageDetailPublicWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import Foundation
import UIKit

class MyPageDetailPublicWorkVC: UIViewController{
    
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
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailPublicWorkTableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageDetailPublicWorkTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailPublicDateTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailPublicDateTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
//MARK:- Table View Data Source

extension MyPageDetailPublicWorkVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCountTableViewCell") as? MyPageDetailCountTableViewCell {
                cell.selectionStyle = .none
                cell.titleLabel.text = "공동업무 참여횟수"
                cell.countLabel.text = "3"
                cell.unitLabel.text = "회"
                print(indexPath.row)
                return cell
            }
        }else*/
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicDateTableViewCell") as? MyPageDetailPublicDateTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        /*
        if indexPath.row == 0{
            return 113
        }else
        */
        if indexPath.row == 0{
            return 44
        }else{
            return 90
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
