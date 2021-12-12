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
    //관리자라면 근무자 정보 받아와야한다.
    var positionId = -1 // 근무자이면 디폴트값 -1
    var isNoData = true
    @IBOutlet var completeRateLabel: UILabel!
    
    lazy var dataManager: MyPageDetailClearWorkDataManager = MyPageDetailClearWorkDataManager()
    //
    var taskData: [MyPageDetailClearWorkTaskData]?
    var taskRate: MyPageDetailClearWorkTaskRate?
    
    @IBOutlet var shadowImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getMyPageDetailClearWork(vc: self, positionId: positionId)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goMonthPage(year: String, month: String){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageDetailClearWorkMonthVC") as? MyPageDetailClearWorkMonthVC else {return}
        nextVC.year = year
        nextVC.month = month
        nextVC.positionId = positionId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK:- View Setup
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        
        let todayGoodsCellNib = UINib(nibName: "MyPageDetailClearWorkTableViewCell", bundle: nil)
        self.tableView.register(todayGoodsCellNib, forCellReuseIdentifier: "MyPageDetailClearWorkTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        //그림자 hidden
        shadowImage.isHidden = true
    }
}
//MARK:- Table View Data Source

extension MyPageDetailClearWorkVC: UITableViewDataSource,UITableViewDelegate {
    //스크롤 상태일 때만 그림자 show
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if self.tableView.contentOffset.y == 0 {
                shadowImage.isHidden = true
                
            }else{
                shadowImage.isHidden = false
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isNoData{
            return 1
        }else{
            if let data = taskData{
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
                cell.titleLabel.text = "업무완수율"
                cell.countLabel.text = "100"
                cell.unitLabel.text = "%"
                print(indexPath.row)
                return cell
            }
        }*/
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.selectionStyle = .none
                cell.bgView.backgroundColor = .none
                cell.titleLabel.text = "완료한 공동업무가 없어요."
                   print(indexPath.row)
               return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkTableViewCell") as? MyPageDetailClearWorkTableViewCell {
                if let data = taskData{
                    let year = data[indexPath.row].year!.substring(from: 2, to: 4)
                    cell.dateLabel.text = "\(year)년 \(data[indexPath.row].month!)월 업무"
                    cell.totalLabel.text = "/ \(data[indexPath.row].totalCount!)"
                    cell.countLabel.text = String(data[indexPath.row].completeCount!)
                    cell.segment.progress = Float(data[indexPath.row].completeCount!) / Float(data[indexPath.row].totalCount!)
                }
                
                cell.selectionStyle = .none
                return cell
            }
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
        if !isNoData{
            if let data = taskData{
              
                goMonthPage(year: data[indexPath.row].year!,month: data[indexPath.row].month! )
            }
        }
    }
    
}
extension MyPageDetailClearWorkVC {
    func didSuccessMyPageDetailClearWork(result: MyPageDetailClearWorkResponse) {
        taskData = result.data?.taskData
        taskRate = result.data?.taskRate
        print(result.message!)
        if let data = taskRate{
            if data.totalTaskCount! != 0{
                completeRateLabel.text = String(Int(Float(data.completeTaskCount!) / Float(data.totalTaskCount!) * 100))
            }else{
                completeRateLabel.text = "0"
            }
            
        }
        
        if taskData!.count != 0{
            isNoData = false
        }else{
            isNoData = true
        }
        tableView.reloadData()
        dismissIndicator()
        print(taskData)
    }
    
    func failedToRequestMyPageDetailClearWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

