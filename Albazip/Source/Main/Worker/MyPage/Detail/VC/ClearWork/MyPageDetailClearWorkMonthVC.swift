//
//  MyPageDetailClearWorkMonthVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

import Foundation
class MyPageDetailClearWorkMonthVC: UIViewController{
    
    var month = ""
    var year = ""
    //관리자라면 근무자 정보 받아와야한다.
    var positionId = -1 // 근무자이면 디폴트값 -1
    var isNoData = true
    lazy var dataManager: MyPageDetailClearWorkMonthDataManager = MyPageDetailClearWorkMonthDataManager()
    //
    var data: [MyPageDetailClearWorkMonthData]?
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        let shortYear = year.substring(from: 2, to: 4)
        titleLabel.text = "\(shortYear)년 \(month)월 업무"
        showIndicator()
        dataManager.getMyPageDetailClearWorkMonth(vc: self, year: year , month: month , positionId: positionId)
    }
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        tableView.tableHeaderView = header
        let todayGoodsCellNib = UINib(nibName: "MyPageDetailClearWorkTableViewCell", bundle: nil)
        self.tableView.register(todayGoodsCellNib, forCellReuseIdentifier: "MyPageDetailClearWorkTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func goDayPage(year: String, month: String, day: String, week_day : String){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageDetailClearWorkDayVC") as? MyPageDetailClearWorkDayVC else {return}
        nextVC.year = year
        nextVC.month = month
        nextVC.day = day
        nextVC.week_day = week_day
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Table View Data Source

extension MyPageDetailClearWorkMonthVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isNoData{
            return 1
        }else{
            if let x = data{
                return x.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
                cell.selectionStyle = .none
                if let x = data{
                    cell.segment.progress = Float(x[indexPath.row].completeCount!) / Float(x[indexPath.row].totalCount!)
                    cell.totalLabel.text = "/ \(x[indexPath.row].totalCount!)"
                    cell.countLabel.text = String(x[indexPath.row].completeCount!)
                    cell.dateLabel.text = "\(x[indexPath.row].month!)/\(x[indexPath.row].day!) \(x[indexPath.row].week_day!) 업무"
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
            return 125
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoData{
            if let x = data{
                goDayPage(year: year,month: x[indexPath.row].month!,  day: x[indexPath.row].day!, week_day: x[indexPath.row].week_day!)
            }
            
        }
    }
    
}
extension MyPageDetailClearWorkMonthVC {
    func didSuccessMyPageDetailClearWorkMonth(result: MyPageDetailClearWorkMonthResponse) {
        data = result.data
        //taskRate = result.data?.taskRate
        print(result.message!)
        
        if data!.count != 0{
            isNoData = false
        }else{
            isNoData = true
        }
        tableView.reloadData()
        dismissIndicator()
        print(data)
    }
    
    func failedToRequestMyPageDetailClearWorkMonth(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}
