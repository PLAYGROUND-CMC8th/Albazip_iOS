//
//  HomeWorkerTodayWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerTodayWorkVC: UIViewController{
    
    var isNoNonCompleteCoData = true
    var isNoCompleteCoData = true
    var isNoNonCompletePerData = true
    var isNoCompletePerData = true
    
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    // 공동 업무
    var nonComCoTask: [HomeWorkerNonComCoTask]?
    var comCoTask: [HomeWorkerComCoTask]?
    var isCoFolded = [Bool]()
    
    // 개인 업무
    var nonComPerTask: [HomeWorkerNonComCoTask]?
    var compPerTask: [HomeWorkerComCoTask]?
    var isPerFolded = [Bool]()
    
    //완료한 사람 배열
    var comWorker: [HomeWorkerComWorkerList]?
    // Datamanager
    lazy var dataManager: HomeWorkerTodayWorkDatamanager = HomeWorkerTodayWorkDatamanager()
    // 완료하기, 미완료하기
    lazy var dataManager3: HomeTodayWorkCheckDatamanager = HomeTodayWorkCheckDatamanager()
    var segValue = 0 // 0이면 공동업무, 1이면 개인업무!
    
    //업무 완료 창
    var clearAlert = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(segValue)
        setUI()
        setupTableView()
        showIndicator()
        dataManager.getHomeWorkerTodayWork(vc: self)
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
        /*
        //corner radius
        let cornerRadius = segment.bounds.height / 2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        segment.clipsToBounds = true
        segment.layer.cornerRadius = cornerRadius
        segment.layer.maskedCorners = maskedCorners*/
        segment.selectedSegmentIndex = segValue
        
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
        tableView.register(UINib(nibName: "MyPageDetailNoClearWorkOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell")
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
                tableView.reloadData()
            case 1:
                segValue = 1
                tableView.reloadData()
            default:
                break;
            }
    }
}
extension HomeWorkerTodayWorkVC: UITableViewDataSource,UITableViewDelegate {

    //섹션 헤더 개수
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //섹션 헤더 셀 지정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as! MyPageDetailClearWorkNoCompleteTableViewCell
        let headerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkNoCompleteTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkNoCompleteTableViewCell
        
        let headerCell2 = Bundle.main.loadNibNamed("HomeWorkerPublicWorkCompleteHeaderTableViewCell", owner: self, options: nil)?.first as! HomeWorkerPublicWorkCompleteHeaderTableViewCell
        
        if segValue == 0{ // 공동업무
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
        }else{ // 개인 업무
            switch (section) {
            case 0:
                headerCell.titleLabel.text = "미완료"
                if let x = nonComPerTask{
                    headerCell.countLabel.text = String(x.count)
                }
                return headerCell
            case 1:
                headerCell.titleLabel.text = "완료"
                if let x = compPerTask{
                    headerCell.countLabel.text = String(x.count)
                }
                return headerCell
            default:
                headerCell.titleLabel.text = "Other";
            }
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
            if section == 0 {
                if isNoNonCompletePerData{
                       return 1
                }else{
                    
                    if let x = nonComPerTask{
                        return x.count
                    }
                }
            }else if section == 1 {
                if isNoCompletePerData{
                       return 1
                }else{
                    
                    if let x = compPerTask{
                        return x.count
                    }
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
                        cell.titleLabel.text = "업무를 모두 완료했어요!"
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
                                cell.taskId = data[indexPath.row].taskId!
                                
                            }
                            print(indexPath.row)
                            return cell
                        }
                    }else{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell") as? MyPageDetailNoClearWorkOpenTableViewCell {
                            cell.selectionStyle = .none
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
                        return cell
                    }
                }
            }
        }else{ // 개인 업무
            if indexPath.section == 0{
                if isNoNonCompletePerData{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                        cell.titleLabel.text = "업무를 모두 완료했어요!"
                        cell.selectionStyle = .none
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    // 접폈는지 펴졌는지
                    if isPerFolded[indexPath.row]{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerPublicWorkTableViewCell") as? HomeWorkerPublicWorkTableViewCell {
                            cell.selectionStyle = .none
                            cell.delegate = self
                            if let data = nonComPerTask{
                                cell.titleLabel.text = data[indexPath.row].takTitle!
                                if let x = data[indexPath.row].taskContent, x == ""{
                                    cell.subLabel.text = "내용 없음"
                                }else{
                                    cell.subLabel.text = data[indexPath.row].taskContent ?? "내용 없음"
                                }
                                cell.taskId = data[indexPath.row].taskId!
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
                if isNoCompletePerData{
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
                        if let data = compPerTask{
                            cell.titleLabel.text = data[indexPath.row].takTitle!
                            cell.subLabel.text = "완료  \(data[indexPath.row].completeTime!.substring(from: 11, to: 16))"
                            cell.taskId = data[indexPath.row].taskId!
                        }
                        print(indexPath.row)
                        return cell
                    }
                }
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
                        return 137
                    }
                }
                
            }else{
                return 82
            }
        }else{
            if indexPath.section == 0{
                if isNoNonCompletePerData{
                    return 82
                }else{
                    if isPerFolded[indexPath.row] == true{
                        return 82
                    }else{
                        return 137
                    }
                }
                
            }else{
                return 82
            }
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
        if segValue == 0{
            if indexPath.section == 0{
                if isCoFolded[indexPath.row] == true{
                    isCoFolded[indexPath.row] = false
                    tableView.reloadData()
                }else{
                    isCoFolded[indexPath.row] = true
                    tableView.reloadData()
                }
            }else{
                presentBottomAlert(message: "이미 완료된 업무입니다.")
            }
        }else{
            if indexPath.section == 0{
                if isPerFolded[indexPath.row] == true{
                    isPerFolded[indexPath.row] = false
                    tableView.reloadData()
                }else{
                    isPerFolded[indexPath.row] = true
                    tableView.reloadData()
                }
            }else{
                presentBottomAlert(message: "이미 완료된 업무입니다.")
            }
        }
    }
}
extension HomeWorkerTodayWorkVC {
    func didSuccessHomeWorkerTodayWork(result: HomeWorkerTodayWorkResponse) {
        
        if let data = result.data{
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
                
                //완료한 배열
                if let comWorker = coTask.comWorker{
                    if let x = comWorker.comWorker{
                        self.comWorker = x
                    }
                }
                
            }
            if let perTask = data.perTask{
                segment.setTitle(perTask.positionTitle!, forSegmentAt: 1)
                nonComPerTask = perTask.nonComPerTask
                if nonComPerTask!.count != 0{
                    isNoNonCompletePerData = false
                    // 테이블뷰 접고 펴기 배열
                    var i = 0
                    while i < nonComPerTask!.count{
                        isPerFolded.append(true)
                        i += 1
                    }
                }else{
                    isNoNonCompletePerData = true
                }
                compPerTask = perTask.compPerTask
                if compPerTask!.count != 0{
                    isNoCompletePerData = false
                }else{
                    isNoCompletePerData = true
                }
            }
            
            
        }
        
        
        /*
        homeWorkerData = result.data
        if let data = homeWorkerData{
            todayInfo = data.todayInfo
            shopInfo = data.shopInfo
            print(shopInfo)
            scheduleInfo = data.scheduleInfo
            taskInfo = data.taskInfo
            boardInfo = data.boardInfo
            //status 설정
            status = (shopInfo!.status)!
            if status == 1{
                isWork = true
            }else{
                isWork = false
            }
            storeNameLabel.text = shopInfo!.shopName!
            
        }
        print(homeWorkerData)
        setUI()
        
        tableView.reloadData()*/
        
        
        tableView.reloadData()
        print(result)
        dismissIndicator()
        
        if clearAlert{
            let newStoryboard = UIStoryboard(name: "HomeManagerStoryboard", bundle: nil)
            if let vc = newStoryboard.instantiateViewController(withIdentifier: "HomeManagerClearAlertVC") as? HomeManagerClearAlertVC {
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: false, completion: nil)
            }
        }
        clearAlert = false
    }
    
    func failedToRequestHomeWorkerTodayWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

//업무 되돌리기, 완료하기 api
extension HomeWorkerTodayWorkVC {
    func didSuccessHomeTodayWorkCheck(result: HomeWorkerTodayWorkResponse) {
        print(result.message)
        //tableView.reloadData()
        dataManager.getHomeWorkerTodayWork(vc: self)
        
    }
    
    func failedToRequestHomeTodayWorkCheck(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

extension HomeWorkerTodayWorkVC: CheckUnCompleteWorkDelegate, CheckCompleteWorkDelegate, CheckCompleteWorkAlertDelegate{
    
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
        let newStoryboard = UIStoryboard(name: "HomeManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "HomeManagerUnClearAlertVC") as? HomeManagerUnClearAlertVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.taskId = taskId
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
}
