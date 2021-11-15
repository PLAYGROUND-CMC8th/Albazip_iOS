//
//  MyPageDetailCommuteRecordVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import Foundation
import UIKit

class MyPageDetailCommuteRecordVC: UIViewController{
    
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var lateCountLabel: UILabel!
    var month = Int("MM".stringFromDate())!
    var year = Int("yyyy".stringFromDate())!
    var isNoData = true
    var lateCount = ""
    @IBOutlet var tableView: UITableView!
    lazy var dataManager: MyPageDetailCommuteRecordDatamanager = MyPageDetailCommuteRecordDatamanager()
    //
    var commuteData: [MyPageDetailCommuteRecordCommuteData]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        monthLabel.text = "\(month)월"
        lateCountLabel.text = lateCount
        
        showIndicator()
        dataManager.getMyPageDetailCommuteRecord(vc: self, year: year, month: month)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        if month - 1 > 0{
            month -= 1
            monthLabel.text = "\(month)월"
            showIndicator()
            dataManager.getMyPageDetailCommuteRecord(vc: self, year: year, month: month)
        }else{
            year -= 1
            month = 12
            monthLabel.text = "\(month)월"
            showIndicator()
            dataManager.getMyPageDetailCommuteRecord(vc: self, year: year, month: month)
        }
    }
    @IBAction func btnRight(_ sender: Any) {
        if month + 1 > 12{
            month = 1
            year += 1
            monthLabel.text = "\(month)월"
            showIndicator()
            dataManager.getMyPageDetailCommuteRecord(vc: self, year: year, month: month)
        }else{
            month += 1
            monthLabel.text = "\(month)월"
            showIndicator()
            dataManager.getMyPageDetailCommuteRecord(vc: self, year: year, month: month)
        }
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        //tableView.register(UINib(nibName: "MyPageDetailCommuteMonthTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCommuteMonthTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailCommuteRecordTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailCommuteRecordTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        //MyPageDetailCommuteRecordTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
//MARK:- Table View Data Source

extension MyPageDetailCommuteRecordVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNoData{
            return 1
        }else{
            if let data = commuteData{
                return data.count
            }
        }
        return 0
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
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.bgView.backgroundColor = .none
                cell.titleLabel.text = "출퇴근 기록이 없어요."
                   print(indexPath.row)
               return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCommuteRecordTableViewCell") as? MyPageDetailCommuteRecordTableViewCell {
                cell.selectionStyle = .none
                if let data = commuteData{
                    cell.dateLabel.text = "\(data[indexPath.row].year!).\(data[indexPath.row].month!).\(data[indexPath.row].day!)"
                    cell.startTime.text = data[indexPath.row].start_time!.insertTime
                    cell.endTime.text = data[indexPath.row].end_time!.insertTime
                }
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
        }else if indexPath.row == 1{
            return 44
        }*/
            return 133
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
extension MyPageDetailCommuteRecordVC {
    func didSuccessMyPageDetailCommuteRecord(result: MyPageDetailCommuteRecordResponse) {
        commuteData = result.data?.commuteData
        
        print(result.message!)
        if commuteData!.count != 0{
            isNoData = false
        }else{
            isNoData = true
        }
        tableView.reloadData()
        dismissIndicator()
        //print(commuteData)
    }
    
    func failedToRequestMyPageDetailCommuteRecord(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

