//
//  HomeWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerVC: BaseViewController{
    
    var isWork = true
    var status = 0
    //
    var homeWorkerData: HomeWorkerData?
    var todayInfo: HomeWorkerTodayInfo?
    var shopInfo: HomeWorkerShopInfo?
    var scheduleInfo: HomeWorkerScheduleInfo?
    var taskInfo: HomeWorkerTaskInfo?
    var boardInfo: [HomeWorkerBoardInfo]?
    
    //타이머
    var minutes: Int = 0
    var seconds: Int = 0
    var secondsLeft: Int = 180
    // Datamanager
    lazy var dataManager: HomeWorkerDatamanager = HomeWorkerDatamanager()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var storeNameView: UIStackView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
        //setTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("MainviewWillAppear")
        
        showIndicator()
        dataManager.getHomeWorker(vc: self)
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeWorkerMainTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerMainTableViewCell")
        tableView.register(UINib(nibName: "HomeWorkerWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerWorkTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerCommunityTableViewCell")
    }
    func setUI(){
        // 배경 색, 테이블 뷰 색 변경해줘야해서
        if isWork{
            tableView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }else{
            tableView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
        }
        self.tabBarController?.tabBar.isHidden = false
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(storeNameViewTapped))
        storeNameView.addGestureRecognizer(tapGestureRecognizer1)
    }
    /*
    func setTimer(){
        //1초마다 타이머 반복 실행
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                //남은 시간(초)에서 1초 빼기
                self.secondsLeft -= 1

                //남은 분
            self.minutes = self.secondsLeft / 60
                //그러고도 남은 초
            self.seconds = self.secondsLeft % 60

                //남은 시간(초)가 0보다 크면
                if self.secondsLeft > 0 {
                    print("\(self.minutes):\(self.seconds)")
                    //self.endTimeLabel.text = "\(minutes):\(seconds)"
                    //self.endTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                } else {
                    print("시간 끝!")
                }
            })
    }*/
    //큐알 페이지로
    @IBAction func btnQRCode(_ sender: Any) {
        if status == 3{ // 쉬는날
            presentBottomAlert(message: "오늘은 쉬는날이에요")
            
        }
        
        else if status == 2{ // 근무후
            presentBottomAlert(message: "이미 근무를 마치고 퇴근한 상태에요")
        }
        
        else{
            if let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerQRCodeVC") as? HomeWorkerQRCodeVC {
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.delegate = self
                nextVC.workerStatus = status
                
            self.present(nextVC, animated: true, completion: nil)
            }
        }
       
    }
    //알람 페이지로
    @IBAction func btnAlarm(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerAlarmVC") as? HomeWorkerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //매장 목록 페이지로
    @objc func storeNameViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerStoreListVC") as? HomeWorkerStoreListVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
// 테이블뷰 extension
extension HomeWorkerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if isWork{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerWorkTableViewCell") as? HomeWorkerWorkTableViewCell {
                    cell.selectionStyle = .none
                    //cell.setTimer()
                    if let data = todayInfo{
                        cell.dateLabel.text = "\(data.month!)/\(data.date!) \(data.day!)요일"
                    }
                    if let data = scheduleInfo{
                        if let x = data.realStartTime{
                            cell.startTimeLabel.text = x.insertTime
                        }else{
                            cell.startTimeLabel.text = data.startTime!.insertTime
                        }
                        if let x = data.remainTime{
                            if x.contains("-"){
                                cell.endTimeLabel.textColor = #colorLiteral(red: 0.9745560288, green: 0.0081703756, blue: 0.009261366911, alpha: 1)
                                let remove = x.replace(target: "-", with: "")
                                cell.endTimeLabel.text = "+ " + remove.insertTime
                            }else{
                                cell.endTimeLabel.textColor = #colorLiteral(red: 0.1411581933, green: 0.1411892474, blue: 0.1411541104, alpha: 1)
                                cell.endTimeLabel.text = x.insertTime
                            }
                            
                        }else{
                            cell.endTimeLabel.text = data.endTime!.insertTime
                        }
                        
                        let position = data.positionTitle!
                        let removePosition = position.replace(target: " ", with: "")
                        cell.positionLabel.text = removePosition
                        cell.honeyPositionLabel.text = removePosition + " 업무"
                        if position.contains("미들"){
                            cell.positionImage.image = #imageLiteral(resourceName: "iconMiddle15Px")
                        }else if position.contains("마감"){
                            cell.positionImage.image = #imageLiteral(resourceName: "iconDone15Px")
                        }else{
                            cell.positionImage.image = #imageLiteral(resourceName: "iconOpen15Px")
                        }
                        
                        //cell.positionImage.image =
                    }
                    if let data = taskInfo{
                        cell.clearPublicCountLabel.text =
                            "\(data.coTask!.completeCount!)"
                        cell.totalPublicCountLabel.text =
                            "/ \(data.coTask!.totalCount!)"
                        if data.coTask!.totalCount! == 0{
                            cell.publicBar.progress = 0.0
                        }else{
                            cell.publicBar.progress = Float(data.coTask!.completeCount!) / Float(data.coTask!.totalCount!)
                        }
                        
                        cell.clearPrivateCountLabel.text =
                            "\(data.perTask!.completeCount!)"
                        cell.totalPrivateCountLabel.text =
                            "/ \(data.perTask!.totalCount!)"
                        if data.perTask!.totalCount! == 0{
                            cell.privateBar.progress = 0.0
                            cell.honeyImage.image = #imageLiteral(resourceName: "img068Px")
                        }else{
                            let rate = Float(data.perTask!.completeCount!) / Float(data.perTask!.totalCount!)
                            cell.privateBar.progress = rate
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
                    
                    cell.delegate = self
                    /*
                    //타이머 관련
                    //남은 시간(초)가 0보다 크면
                    if self.secondsLeft > 0 {
                        print("\(self.minutes):\(self.seconds)")
                        //self.endTimeLabel.text = "\(minutes):\(seconds)"
                        cell.endTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                    } else {
                        print("시간 끝!")
                    }*/
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerMainTableViewCell") as? HomeWorkerMainTableViewCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    if let data = todayInfo{
                        cell.dateLabel.text = "\(data.month!)/\(data.date!) \(data.day!)요일"
                    }
                    
                    switch status {
                    case 0: // 근무전
                        cell.heightConstraint.constant = 65
                        cell.beeImage.image = #imageLiteral(resourceName: "imgBeeWork")
                        cell.btnNextPage.setTitle("출근하기", for: .normal)
                        cell.btnNextPage.isHidden = false
                        cell.titleLabel.text = "오늘은 근무날이에요!"
                    case 2: // 근무 후
                        cell.heightConstraint.constant = 65
                        cell.beeImage.image = #imageLiteral(resourceName: "imgBeeDone")
                        cell.btnNextPage.setTitle("완료한 업무", for: .normal)
                        cell.btnNextPage.isHidden = false
                        cell.titleLabel.text = "오늘 하루도 수고했어요."
                    default: // 3 휴무
                        cell.heightConstraint.constant = 80
                        cell.beeImage.image = #imageLiteral(resourceName: "imgBeeSleep")
                        cell.btnNextPage.isHidden = true
                        cell.titleLabel.text = "오늘은 쉬는날이에요."
                    }
                    cell.delegate = self
                    
                    
                    
                    
                    return cell
                }
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerCommunityTableViewCell") as? HomeManagerCommunityTableViewCell {
                cell.delegate = self
                if let data = boardInfo{
                    cell.setCell(boardInfo: data)
                }
                cell.bottomPadding.constant = 26
                cell.selectionStyle = .none
                return cell
            }
 
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 480
        case 1:
            return tableView.estimatedRowHeight
       
        default:
            return 0
        }
    }
}
extension HomeWorkerVC: HomeWorkerAddWorkDelegate{
    // 완료 업무 페이지 or QR 페이지
    func goNextPage() {
        if status == 2{
            if let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerTodayWorkVC") as? HomeWorkerTodayWorkVC {
                nextVC.status = status
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }else{
            if let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerQRCodeVC") as? HomeWorkerQRCodeVC {
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.delegate = self
                nextVC.workerStatus = status
               
            self.present(nextVC, animated: true, completion: nil)
            }
        }
        
    }
}
extension HomeWorkerVC: HomeWorkerWorkDeleagate{
    //공동 업무 페이지
    func goPublicWork() {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerTodayWorkVC") as? HomeWorkerTodayWorkVC else {return}
        nextVC.segValue = 0
        nextVC.status = status
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //개인 업무 페이지
    func goPrivateWork() {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerTodayWorkVC") as? HomeWorkerTodayWorkVC else {return}
        nextVC.segValue = 1
        nextVC.status = status
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension HomeWorkerVC: HomeCommunityViewCellDelegate{
    func collectionView(collectionviewcell: HomeManagerCoummunityCollectionViewCell?, index: Int, didTappedInTableViewCell: HomeManagerCommunityTableViewCell) {
        print("\(index)번째 셀입니다.")
        if let data = boardInfo{
            if data.count != 0{
                let newStoryboard = UIStoryboard(name: "CommunityWorkerStoryboard", bundle: nil)
                guard let nextVC = newStoryboard.instantiateViewController(identifier: "CommunityWorkerNoticeDetailVC") as? CommunityWorkerNoticeDetailVC else {return}
                nextVC.confirm = data[index].confirm!
                nextVC.noticeId = data[index].id!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    func goCommunityPage() {
        print("소통창 페이지로 이동")
        guard let second = tabBarController?.viewControllers?[1] else { return }
                tabBarController?.selectedViewController = second
    }
    
    
}
extension HomeWorkerVC {
    func didSuccessHomeWorker(result: HomeWorkerResponse) {
        
        
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
        //isWork = true
        //setTimer()
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestHomeWorker(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}


extension HomeWorkerVC: HomeWorkerQRCodeDelegate{
    func workStart() {
        print("workStart")
        showIndicator()
        dataManager.getHomeWorker(vc: self)
    }
}
