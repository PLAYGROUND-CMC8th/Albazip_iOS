//
//  HomeManagerTodayWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerTodayWorkVC: UIViewController{
    var isNoNonCompleteCoData = true
    var isNoCompleteCoData = true
    var isNoPerData = true
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var status = -1
    var segValue = 0 // 0이면 공동업무, 1이면 개인업무!
    // 공동 업무
    var nonComCoTask: [HomeWorkerNonComCoTask]?
    var comCoTask: [HomeWorkerComCoTask]?
    var isCoFolded = [Bool]()
    // 개인 업무
    var perTask: [HomeManagerPerTaskList]?
    
    //완료한 사람 배열
    var comWorker: [HomeWorkerComWorkerList]?
    
    // 전체조회
    lazy var dataManager: HomeManagerTodayWorkDatamanager = HomeManagerTodayWorkDatamanager()
    // 삭제하기
    lazy var dataManager2: HomeManagerTodayWorkDeleteDatamanager = HomeManagerTodayWorkDeleteDatamanager()
    // 완료하기, 미완료하기
    lazy var dataManager3: HomeTodayWorkCheckDatamanager = HomeTodayWorkCheckDatamanager()
    
    var deleteIndex = -1
    //업무 완료 창
    var clearAlert = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(segValue)
        setUI()
        setupTableView()
        showIndicator()
        dataManager.getHomeManagerTodayWork(vc: self)
    }
    func setUI() {
        
        segment.cornerRadius = segment.bounds.height / 2
        let attributes = [
            NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes , for: .selected)
        
        let attributes2 = [
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6430723071, green: 0.6431827545, blue: 0.6430577636, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes2 , for: .normal)
        
        segment.selectedSegmentIndex = segValue
        self.segment.layer.cornerRadius = 50.0
        self.segment.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.segment.layer.borderWidth = 1.0
        self.segment.layer.masksToBounds = true
    }
    func setupTableView() {
        
//MyPageDetailClearWorkNoCompleteTableViewCell
        
        //테이블뷰 헤더 등록
        // Register the custom header view.
        //미완료 헤더
           tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
               forHeaderFooterViewReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")
        //완료 헤더
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkCompleteHeaderTableViewCell", bundle: nil),
            forHeaderFooterViewReuseIdentifier: "HomeWorkerPublicWorkCompleteHeaderTableViewCell")
        //HomeWorkerPublicWorkCompleteHeaderTableViewCell
        
        //미완료 82
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerPublicWorkTableViewCell")
        //미완료 펼쳤을때 버전 137
        tableView.register(UINib(nibName: "HomeManagerTodayWorkOpenDeleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerTodayWorkOpenDeleteTableViewCell")
        //완료 82
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerPublicWorkCompleteTableViewCell")
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
        
        // 개인 업무
        tableView.register(UINib(nibName: "HomeManagerWorkPrivateTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerWorkPrivateTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func indexChanged(_ sender: Any) {
        switch segment.selectedSegmentIndex {
            case 0:
                segValue = 0
                //setupTableView()
                tableView.reloadData()
            case 1:
                segValue = 1
                //setupTableView()
                tableView.reloadData()
            default:
                break;
            }
    }
}
    


extension HomeManagerTodayWorkVC: UITableViewDataSource,UITableViewDelegate {

    //섹션 헤더 개수
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segValue == 0{
            return 2
        }else{
            return 1
        }
    }
    //섹션 헤더 셀 지정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as! MyPageDetailClearWorkNoCompleteTableViewCell
        let headerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkNoCompleteTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkNoCompleteTableViewCell
        
        let headerCell2 = Bundle.main.loadNibNamed("HomeWorkerPublicWorkCompleteHeaderTableViewCell", owner: self, options: nil)?.first as! HomeWorkerPublicWorkCompleteHeaderTableViewCell
        
        if segValue == 0{ // 공동업무
            print("첫번째 헤더")
            switch (section) {
            case 0:
                headerCell.titleLabel.text = "미완료"
                
                if let x = nonComCoTask{
                    headerCell.countLabel.text = String(x.count)
                }
                return headerCell
            case 1:
                
                if let x = comCoTask{
                    headerCell2.countLabel.text = String(x.count)
                    
                }
                if let x = comWorker{
                    headerCell2.setCell(data: x)
                }
                return headerCell2
              
            default:
                headerCell.titleLabel.text = "Other";
            }
        }else if segValue == 1{ // 개인 업무
            print("두번째 헤더")
            return nil
        }

        return headerCell
    }
    //섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segValue == 0{ // 공동업무
            if section == 0 {
                if isNoNonCompleteCoData{
                       return 1
                }else{
                    
                    if let x = nonComCoTask{
                        return x.count
                    }
                }
            }else if section == 1 {
                if isNoCompleteCoData{
                       return 1
                }else{
                    
                    if let x = comCoTask{
                        return x.count
                    }
                }
            }
        }else{ // 개인업무
            
            if isNoPerData{
                    return 1
            }else{
                    
                if let x = perTask{
                        return x.count
                }
            }
            
        }
       
        return 0
    }
    //셀의 값
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segValue == 0{ // 공동업무
            if indexPath.section == 0{
                if isNoNonCompleteCoData{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                        cell.titleLabel.text = "추가된 업무가 없어요!"
                        cell.selectionStyle = .none
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    // 접폈는지 펴졌는지
                    if isCoFolded[indexPath.row]{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerPublicWorkTableViewCell") as? HomeWorkerPublicWorkTableViewCell {
                            cell.selectionStyle = .none
                            cell.delegate = self
                            
                            if let data = nonComCoTask{
                                cell.titleLabel.text = data[indexPath.row].takTitle!
                                if let x = data[indexPath.row].taskContent, x == ""{
                                    cell.subLabel.text = "내용 없음"
                                }else{
                                    cell.subLabel.text = data[indexPath.row].taskContent ?? "내용 없음"
                                }
                                cell.taskId =  data[indexPath.row].taskId!
                                
                            }
                            print(indexPath.row)
                            if status == 2{
                                cell.btnCheck.isHidden = true
                            }else{
                                cell.btnCheck.isHidden = false
                            }
                            return cell
                        }
                    }else{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerTodayWorkOpenDeleteTableViewCell") as? HomeManagerTodayWorkOpenDeleteTableViewCell {
                            cell.selectionStyle = .none
                            cell.cellIndex = indexPath.row
                            cell.delegate = self
                            if let data = nonComCoTask{
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
                if isNoCompleteCoData{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                        cell.titleLabel.text = "완료된 업무가 없어요."
                        cell.selectionStyle = .none
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerPublicWorkCompleteTableViewCell") as? HomeWorkerPublicWorkCompleteTableViewCell {
                        cell.selectionStyle = .none
                        cell.delegate = self
                        if let data = comCoTask{
                            cell.titleLabel.text = data[indexPath.row].takTitle!
                            cell.subLabel.text = "완료  \(data[indexPath.row].completeTime!.substring(from: 11, to: 16))"
                            cell.taskId = data[indexPath.row].taskId!
                        }
                        print(indexPath.row)
                        if status == 2{
                            cell.btnCheck.isHidden = true
                        }else{
                            cell.btnCheck.isHidden = false
                        }
                        return cell
                    }
                }
            }
        }else{ // 개인 업무
            if isNoPerData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.titleLabel.text = "개인 업무가 없어요."
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerWorkPrivateTableViewCell") as? HomeManagerWorkPrivateTableViewCell {
                    if let data = perTask{
                        cell.titleLabel.text = data[indexPath.row].workerTitle!
                        cell.workerName.text = data[indexPath.row].workerName!
                        cell.completeCount.text = "\(data[indexPath.row].completeCount!)"
                        cell.totalCount.text = "/ \(data[indexPath.row].totalCount!)"
                        if data[indexPath.row].totalCount! == 0{
                            cell.progress.progress = 0.0
                            cell.honeyImage.image = #imageLiteral(resourceName: "img068Px")
                        }else{
                            let rate = Float(data[indexPath.row].completeCount!) / Float(data[indexPath.row].totalCount!)
                            cell.progress.progress = rate
                            if rate >= 0, rate < 0.3{
                                cell.honeyImage.image = #imageLiteral(resourceName: "img068Px")
                            }else if rate >= 0.3, rate < 0.6{
                                cell.honeyImage.image = #imageLiteral(resourceName: "img3068Px")
                            }else if rate >= 0.6, rate < 0.9{
                                cell.honeyImage.image = #imageLiteral(resourceName: "img6068Px")
                            }else{
                                cell.honeyImage.image = #imageLiteral(resourceName: "img9068Px")
                            }
                        }
                    }
                    
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if segValue == 0{
            return 50
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segValue == 0{
            if indexPath.section == 0{
                if isNoNonCompleteCoData{
                    return 82
                }else{
                    if isCoFolded[indexPath.row] == true{
                        return 82
                    }else{
                        return tableView.estimatedRowHeight
                    }
                }
                
            }else{
                return 82
            }
        }else{
            return 133
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
        if segValue == 0{
            if section == 0{
                return 43
            }
            return 0
        }else{
            return 0
        }
    }
    // Select Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("\(indexPath.section): \(indexPath.row)")
        if segValue == 0{
            if indexPath.section == 0{
                if !isNoNonCompleteCoData{
                    if isCoFolded[indexPath.row] == true{
                        isCoFolded[indexPath.row] = false
                        tableView.reloadData()
                    }else{
                        isCoFolded[indexPath.row] = true
                        tableView.reloadData()
                    }
                }
                
            }else{
                if !isNoCompleteCoData{
                    presentBottomAlert(message: "이미 완료된 업무입니다.")
                }
                
            }
        }else{
            if !isNoPerData{
                //개인업무 페이지로
                if let data = perTask{
                    
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkDetailVC") as? HomeManagerTodayWorkDetailVC else {return}
                    nextVC.workerId = data[indexPath.row].workerId!
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
            
        }
    }
}
extension HomeManagerTodayWorkVC {
    func didSuccessHomeManagerTodayWork(result: HomeManagerTodayWorkResponse) {
        
        if let data = result.data{
            //공동 업무
            if let coTask = data.coTask{
                nonComCoTask = coTask.nonComCoTask
                if nonComCoTask!.count != 0{
                    isNoNonCompleteCoData = false
                    // 테이블뷰 접고 펴기 배열
                    var i = 0
                    while i < nonComCoTask!.count{
                        isCoFolded.append(true)
                        i += 1
                    }
                }else{
                    isNoNonCompleteCoData = true
                }
                comCoTask = coTask.comCoTask
                if comCoTask!.count != 0{
                    isNoCompleteCoData = false
                    
                }else{
                    isNoCompleteCoData = true
                }
                
                if let comWorker = coTask.comWorker{
                    if let x = comWorker.comWorker{
                        self.comWorker = x
                    }
                }
            }
           
            // 개인 업무
            perTask = data.perTask
            if perTask!.count != 0{
                isNoPerData = false
                    
            }else{
                    isNoPerData = true
            }
            
            
           
        }
        
        tableView.reloadData()
        print(result)
        dismissIndicator()
        
        if clearAlert{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeManagerClearAlertVC") as? HomeManagerClearAlertVC {
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: false, completion: nil)
            }
        }
        clearAlert = false
    }
    
    func failedToRequestHomeManagerTodayWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    
    func showClearAlert(){
        
    }
}

extension HomeManagerTodayWorkVC: HomeManagerTodayWorkOpenDeleteDelegate, HomeManagerTodayWorkDeleteDelegate{
    func deletePublicWork(index: Int) {
        print("\(index) 열 삭제")
        deleteIndex = index
        showIndicator()
        dataManager2.getHomeManagerTodayWorkDelete(taskId: nonComCoTask![index].taskId!, vc: self)
    }
    
    func deletePublicWorkAlert(index: Int) {
        print("\(index) 열 삭제하는 알림창")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeManagerTodayWorkDeleteVC") as? HomeManagerTodayWorkDeleteVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.cellIndex = index
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    
}
//공동업무 삭제 api
extension HomeManagerTodayWorkVC {
    func didSuccessHomeManagerTodayWorkDelete(result: HomeManagerTodayWorkDeleteResponse) {
        
        print(result)
        nonComCoTask!.remove(at: deleteIndex)
        if nonComCoTask!.count != 0{
            isNoNonCompleteCoData = false
        }else{
            isNoNonCompleteCoData = true
        }
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestHomeManagerTodayWorkDelete(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
//업무 되돌리기, 완료하기 api
extension HomeManagerTodayWorkVC {
    func didSuccessHomeTodayWorkCheck(result: HomeWorkerTodayWorkResponse) {
        print(result.message)
        //tableView.reloadData()
        dataManager.getHomeManagerTodayWork(vc: self)
        
    }
    
    func failedToRequestHomeTodayWorkCheck(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

extension HomeManagerTodayWorkVC: CheckUnCompleteWorkDelegate, CheckCompleteWorkDelegate, CheckCompleteWorkAlertDelegate{
    
    // 진짜 되돌리겠습니까 경고창에서 삭제 눌렀을 때
    func readyToUnCkeckWork(taskId: Int) {
        showIndicator()
        dataManager3.getHomeTodayWorkCheck(taskId: taskId, vc: self)
    }
    
    
    //미완료 셀 체크했을때
    func checkUnCompleteWork(taskId: Int) {
        print(taskId)
        clearAlert = true
        showIndicator()
        dataManager3.getHomeTodayWorkCheck(taskId: taskId, vc: self)
    }
    //완료 셀 체크했을 때
    func checkCompleteWork(taskId: Int) {
        print(taskId)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeManagerUnClearAlertVC") as? HomeManagerUnClearAlertVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.taskId = taskId
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
}

