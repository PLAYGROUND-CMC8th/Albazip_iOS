//
//  MyPageManagerWorkListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/05.
//

import Foundation
import UIKit

struct WorkList{
    var title: String
    var content: String
}

class MyPageManagerWorkListVC: UIViewController{
    
    
    @IBOutlet var tableView: UITableView!
    var totalCount = 0
    var totalList = [WorkList]()
    var replaceData = false
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
        
        return totalList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList1TableViewCell") as? MyPageManagerWorkList1TableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        
        case totalList.count+1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList3TableViewCell") as? MyPageManagerWorkList3TableViewCell {
                cell.selectionStyle = .none
                cell.myPageManagerWorkList3Delegate = self
                print(indexPath.row)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList2TableViewCell") as? MyPageManagerWorkList2TableViewCell {
                
                cell.selectionStyle = .none
                cell.cellIndex = indexPath.row
                cell.myPageManagerWorkList2Delegate = self
                if replaceData{
                    cell.titleLabel.text = totalList[indexPath.row - 1].title
                    cell.subLabel.text = totalList[indexPath.row - 1].content
                }else{
                    totalList[indexPath.row - 1] = WorkList(title: cell.titleLabel.text!, content: cell.subLabel.text!)
                }
                
                
                print(indexPath.row)
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 143
        case totalList.count+1:
            return 60
        default:
            
        return 110
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
}

extension MyPageManagerWorkListVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    func deleteCell2(_ myPageManagerWorkList2TableViewCell: MyPageManagerWorkList2TableViewCell) {
        //totalList.remove(at: myPageManagerWorkList2TableViewCell.cellIndex! - 1)
        //tableView.reloadData()
    }
    
    func deleteCell(index: Int) {
        replaceData = false
        tableView.reloadData()
        print(totalList)
        totalList.remove(at: index - 1)
        
        print(totalList)
        replaceData = true
        tableView.reloadData()
        //replaceData = false
        print(totalList)
    }
    
    func addWork() {
        replaceData = false
        totalList.append(WorkList(title: "",content: ""))
        print(totalList)
        tableView.reloadData()
        print(totalList)
    }
    
    
}
