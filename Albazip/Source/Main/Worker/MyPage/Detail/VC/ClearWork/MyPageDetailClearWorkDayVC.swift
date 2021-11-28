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
    var isFolded = [Bool]()
    
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
        //미완료 펼쳤을때 버전 137
        tableView.register(UINib(nibName: "MyPageDetailNoClearWorkOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell")
        
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
    /*
    //섹션 헤더 고정 해제
    @available(iOS 2.0, *)
        public func scrollViewDidScroll(_ scrollView: UIScrollView){
            // let scrollHeaderHeight = friendsTableView.sectionHeaderHeight
            let scrollHeaderHeight = tableView.rowHeight
            
            if scrollView.contentOffset.y <= scrollHeaderHeight{
                if scrollView.contentOffset.y >= 0 {
                    scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
                }
            } else if (scrollView.contentOffset.y >= scrollHeaderHeight){
                scrollView.contentInset = UIEdgeInsets(top: -scrollHeaderHeight, left: 0, bottom: 0, right: 0)
            }
        }*/
    
    
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
                    cell.titleLabel.text = "업무를 모두 완료했어요!"
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                // 접폈는지 펴졌는지
                if isFolded[indexPath.row]{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkTableViewCell") as? MyPageDetailNoClearWorkTableViewCell {
                        cell.selectionStyle = .none
                        if let data = nonCompleteTaskData{
                            cell.titlelLabel.text = data[indexPath.row].title!
                            if data[indexPath.row].content == ""{
                                cell.subLabel.text = "내용 없음"
                            }else{
                                cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                            }
                            
                        }
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell") as? MyPageDetailNoClearWorkOpenTableViewCell {
                        cell.selectionStyle = .none
                        if let data = nonCompleteTaskData{
                            cell.titleLabel.text = data[indexPath.row].title!
                            if data[indexPath.row].content == ""{
                                cell.subLabel.text = "내용 없음"
                            }else{
                                cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                            }
                            let position = data[indexPath.row].writer_position ?? ""
                            let name = data[indexPath.row].writer_name ?? ""
                            let date = data[indexPath.row].register_date!.insertDate
                            cell.writerNameLabel.text = position + " " + name + " · " + date
                            
                        }
                        print(indexPath.row)
                        return cell
                    }
                }
                
            }
        }else if indexPath.section == 1{
            if isNoCompleteData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.titleLabel.text = "완료된 업무가 없어요."
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                    cell.selectionStyle = .none
                    if let data = completeTaskData{
                        cell.titleLabel.text = data[indexPath.row].title!
                        cell.subLabel.text = "완료  \(data[indexPath.row].complete_date!.substring(from: 11, to: 16))"
                        
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
        if indexPath.section == 0{
            if isNoNonCompleteData{
                return 82
            }else{
                if isFolded[indexPath.row] == true{
                    return 82
                }else{
                    return 137
                }
            }
            
        }else{
            return 82
        }
        
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
        if !isNoNonCompleteData{
            if indexPath.section == 0{
                if isFolded[indexPath.row] == true{
                    isFolded[indexPath.row] = false
                    tableView.reloadData()
                }else{
                    isFolded[indexPath.row] = true
                    tableView.reloadData()
                }
            }else{
                presentBottomAlert(message: "이미 완료된 업무입니다.")
            }
        }
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
            // 테이블뷰 접고 펴기 배열
            var i = 0
            while i < nonCompleteTaskData!.count{
                isFolded.append(true)
                i += 1
            }
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
