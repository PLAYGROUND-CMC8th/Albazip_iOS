//
//  HomeManagerTodayWorkDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import Foundation
class HomeManagerTodayWorkDetailVC: UIViewController{
    // 공동 업무
    var nonComPerTask: [HomeWorkerNonComCoTask]?
    var compPerTask: [HomeWorkerComCoTask]?
    var isFolded = [Bool]()
    
    var isNoNonComPerTask = true
    var isNoCompPerTask = true
    var workerId = -1
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    // Datamanager
    lazy var dataManager:  HomeManagerTodayWorkDetailDatamanager =  HomeManagerTodayWorkDetailDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getHomeManagerTodayWorkDetail(workerId: workerId, vc: self)
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
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeManagerTodayWorkDetailVC: UITableViewDataSource,UITableViewDelegate {
    
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
            if let x = nonComPerTask{
                headerCell.countLabel.text = String(x.count)
            }
        case 1:
            headerCell.titleLabel.text = "완료"
            if let x = compPerTask{
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
            if isNoNonComPerTask{
                   return 1
            }else{
                if let x = nonComPerTask{
                    return x.count
                }
            }
        }else if section == 1 {
            if isNoCompPerTask{
                   return 1
            }else{
                if let x = compPerTask{
                    return x.count
                }
            }
        }
        return 0
    }
    //셀의 값
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if isNoNonComPerTask{
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
                        if let data = nonComPerTask{
                            cell.titlelLabel.text = data[indexPath.row].takTitle!
                            if data[indexPath.row].taskContent == ""{
                                cell.subLabel.text = "내용 없음"
                            }else{
                                cell.subLabel.text = data[indexPath.row].taskContent ?? "내용 없음"
                            }
                            
                        }
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell") as? MyPageDetailNoClearWorkOpenTableViewCell {
                        cell.selectionStyle = .none
                        if let data = nonComPerTask{
                            cell.titleLabel.text = data[indexPath.row].takTitle!
                            if data[indexPath.row].taskContent == ""{
                                cell.subLabel.text = "내용 없음"
                            }else{
                                cell.subLabel.text = data[indexPath.row].taskContent ?? "내용 없음"
                            }
                            let position = data[indexPath.row].writerTitle ?? ""
                            let name = data[indexPath.row].writerName ?? ""
                            let date = data[indexPath.row].registerDate!.insertDate
                            cell.writerNameLabel.text = position + " " + name + " · " + date
                            
                        }
                        print(indexPath.row)
                        return cell
                    }
                }
                
            }
        }else if indexPath.section == 1{
            if isNoCompPerTask{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.titleLabel.text = "완료된 업무가 없어요."
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                    cell.selectionStyle = .none
                    if let data = compPerTask{
                        cell.titleLabel.text = data[indexPath.row].takTitle!
                        cell.subLabel.text = "완료  \(data[indexPath.row].completeTime!.substring(from: 11, to: 16))"
                        
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
            if isNoNonComPerTask{
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
        if indexPath.section == 0{
            if !isNoNonComPerTask{
                if isFolded[indexPath.row] == true{
                    isFolded[indexPath.row] = false
                    tableView.reloadData()
                }else{
                    isFolded[indexPath.row] = true
                    tableView.reloadData()
                }
            }
            
        }else{
            if !isNoCompPerTask{
                presentBottomAlert(message: "이미 완료된 업무입니다.")
            }
        }
    }
}

extension HomeManagerTodayWorkDetailVC {
    func didSuccessHomeManagerTodayWorkDetail(result: HomeManagerTodayWorkDetailResponse) {
        
        if let data = result.data{
            titleLabel.text = data.positionTitle! + " 업무"
            //미완료
           
            nonComPerTask = data.nonComPerTask
                if nonComPerTask!.count != 0{
                    isNoNonComPerTask = false
                    // 테이블뷰 접고 펴기 배열
                    var i = 0
                    while i < nonComPerTask!.count{
                        isFolded.append(true)
                        i += 1
                    }
                }else{
                    isNoNonComPerTask = true
                }
            
            //완료
            compPerTask = data.compPerTask
                if compPerTask!.count != 0{
                    isNoCompPerTask = false
                    
                }else{
                    isNoCompPerTask = true
                }
            }
           
            
        tableView.reloadData()
        print(result)
        dismissIndicator()
    }
    
    func failedToRequestHomeManagerTodayWorkDetail(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
