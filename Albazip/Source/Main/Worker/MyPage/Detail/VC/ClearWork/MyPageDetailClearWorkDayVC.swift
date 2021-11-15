//
//  MyPageDetailClearWorkDayVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

import Foundation
class MyPageDetailClearWorkDayVC: UIViewController{
    
    var month = ""
    var year = ""
    var day = ""
    var week_day = ""
    
    //관리자라면 근무자 정보 받아와야한다.
    var positionId = -1 // 근무자이면 디폴트값 -1
    var isNoNonCompleteData = true
    var isNoCompleteData = true
    lazy var dataManager: MyPageDetailClearWorkDayDatamanager = MyPageDetailClearWorkDayDatamanager()
    //
    var nonCompleteTaskData: [MyPageDetailClearWorkDayNonCompleteTaskData]?
    var completeTaskData: [MyPageDetailClearWorkDayCompleteTaskData]?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        titleLabel.text = "\(month)/\(day) \(week_day) 업무"
        
        showIndicator()
        dataManager.getMyPageDetailClearWorkDay(vc: self, year: year , month: month ,day: day, positionId: positionId)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
    //MARK:- View Setup
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        
//MyPageDetailClearWorkNoCompleteTableViewCell
        
        //테이블뷰 헤더 등록
        // Register the custom header view.
           tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
               forHeaderFooterViewReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")
        
        
        //미완료 82
        tableView.register(UINib(nibName: "MyPageDetailNoClearWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailNoClearWorkTableViewCell")
        //완료 82
        tableView.register(UINib(nibName: "MyPageDetailPublicWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailPublicWorkTableViewCell")
        /*
        //미완료, 완료 헤더 50
        tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")*/
        //모두 완료: 100
        tableView.register(UINib(nibName: "MyPageDetailAllClearWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailAllClearWorkTableViewCell")
        
        //미완료, 완료 중간 구분자 43
        tableView.register(UINib(nibName: "MyPageDetailClearWorkMiddleTableViewCell", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "MyPageDetailClearWorkMiddleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
extension MyPageDetailClearWorkDayVC: UITableViewDataSource,UITableViewDelegate {

    //섹션 헤더 개수
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //섹션 헤더 셀 지정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as! MyPageDetailClearWorkNoCompleteTableViewCell
        let headerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkNoCompleteTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkNoCompleteTableViewCell
        switch (section) {
        case 0:
            headerCell.titleLabel.text = "미완료"
            if let x = nonCompleteTaskData{
                headerCell.countLabel.text = String(x.count)
            }
        case 1:
            headerCell.titleLabel.text = "완료"
            if let x = completeTaskData{
                headerCell.countLabel.text = String(x.count)
            }
          
          //return sectionHeaderView
        default:
            headerCell.titleLabel.text = "Other";
        }
        print("헤더헤더")
        return headerCell
    }
    //섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isNoNonCompleteData{
                   return 1
            }else{
                if let x = nonCompleteTaskData{
                    return x.count
                }
            }
        }else if section == 1 {
            if isNoCompleteData{
                   return 1
            }else{
                if let x = completeTaskData{
                    return x.count
                }
            }
        }
        return 0
    }
    //셀의 값
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if isNoNonCompleteData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkTableViewCell") as? MyPageDetailNoClearWorkTableViewCell {
                    cell.selectionStyle = .none
                    if let data = nonCompleteTaskData{
                        cell.titlelLabel.text = data[indexPath.row].title!
                        cell.subLabel.text = data[indexPath.row].content!
                        
                    }
                    print(indexPath.row)
                    return cell
                }
            }
        }else if indexPath.section == 1{
            if isNoCompleteData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                    cell.selectionStyle = .none
                    if let data = completeTaskData{
                        cell.titleLabel.text = data[indexPath.row].title!
                        cell.subLabel.text = "완료  \(data[indexPath.row].complete_date!.insertDate)"
                        
                    }
                    print(indexPath.row)
                    return cell
                }
            }
        }else{
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    //푸터
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkMiddleTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkMiddleTableViewCell
        // 마지막 section은 footer 미표출

        if section == 0{
            return footerCell
        }else{
            
            return nil
        }
        
    }
    
    //푸터 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // footer 영역 크기 = 12 (마지막 section의 footer 크기는 0)
        if section == 0{
            return 43
        }
        return 0
    }
    // Select Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("\(indexPath.section): \(indexPath.row)")
    }
}
extension MyPageDetailClearWorkDayVC {
    func didSuccessMyPageDetailClearWorkDay(result: MyPageDetailClearWorkDayResponse) {
        nonCompleteTaskData = result.data?.nonCompleteTaskData
        completeTaskData = result.data?.completeTaskData
        //taskRate = result.data?.taskRate
        print(result.message!)
        
        if nonCompleteTaskData!.count != 0{
            isNoNonCompleteData = false
        }else{
            isNoNonCompleteData = true
        }
        print(isNoNonCompleteData)
        if completeTaskData!.count != 0{
            isNoCompleteData = false
        }else{
            isNoCompleteData = true
        }
        print(isNoCompleteData)
        tableView.reloadData()
        dismissIndicator()
        print(completeTaskData)
        print(nonCompleteTaskData)
    }
    
    func failedToRequestMyPageDetailClearWorkDay(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}
