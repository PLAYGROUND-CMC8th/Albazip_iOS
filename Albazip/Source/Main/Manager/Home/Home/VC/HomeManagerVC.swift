//
//  HomeManagerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerVC: BaseViewController{
    
    var isOpen = true
    var status = 0
    //
    var homeManagerData: HomeManagerData?
    var todayInfo: HomeManagerTodayInfo?
    var shopInfo: HomeManagerShopInfo?
    var workerInfo: [HomeManagerWorkerInfo]?
    var taskInfo: HomeManagerTaskInfo?
    //근무자꺼 재사용
    var boardInfo: [HomeWorkerBoardInfo]?
    
    // 오픈 미들 마감 근무자
    var openInfo = [HomeManagerWorkerInfo]()
    var middleInfo = [HomeManagerWorkerInfo]()
    var closeInfo = [HomeManagerWorkerInfo]()
    
    // Datamanager
    lazy var dataManager: HomeManagerDatamanager = HomeManagerDatamanager()
    @IBOutlet var mainView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var storeNameView: UIStackView!
    @IBOutlet var storeNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        showIndicator()
        dataManager.getHomeManager(vc: self)
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeManagerMainTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerMainTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerOpenTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerCommunityTableViewCell")
    }
    func setUI(){
        // 배경 색, 테이블 뷰 색 변경해줘야해서
        if isOpen{
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
    //큐알 페이지로
    @IBAction func btnQRCode(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerQRCodeVC") as? HomeManagerQRCodeVC else {return}
        nextVC.storeName = storeNameLabel.text!
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //알람 페이지로
    @IBAction func btnAlarm(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAlarmVC") as? HomeManagerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    //매장 목록 페이지로
    @objc func storeNameViewTapped(sender: UITapGestureRecognizer) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerStoreListVC") as? HomeManagerStoreListVC else {return}
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
extension HomeManagerVC: HomeCommunityViewCellDelegate{
    //각각의 소통창 페이지로
    func collectionView(collectionviewcell: HomeManagerCoummunityCollectionViewCell?, index: Int, didTappedInTableViewCell: HomeManagerCommunityTableViewCell) {
        print("\(index)번째 셀입니다.")
        if let data = boardInfo{
            if data.count != 0{
                let newStoryboard = UIStoryboard(name: "CommunityManagerStoryboard", bundle: nil)
                guard let nextVC = newStoryboard.instantiateViewController(identifier: "CommunityManagerNoticeDetailVC") as? CommunityManagerNoticeDetailVC else {return}
                //nextVC.confirm = data[index].confirm!
                nextVC.noticeId = data[index].id!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    //소통창 페이지로
    func goCommunityPage() {
        print("소통창 페이지로 이동")
        guard let second = tabBarController?.viewControllers?[1] else { return }
                tabBarController?.selectedViewController = second
    }
    
    
}
// 테이블뷰 extension
extension HomeManagerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if isOpen{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerOpenTableViewCell") as? HomeManagerOpenTableViewCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    // 날짜
                    if let data = todayInfo{
                        cell.dateLabel.text = "\(data.month!)/\(data.date!) \(data.day!)요일"
                    }
                    
                    // 오늘의 할일
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
                            
                        }else{
                            let rate = Float(data.perTask!.completeCount!) / Float(data.perTask!.totalCount!)
                            cell.privateBar.progress = rate
                        }
                    }
                    //오늘 근무자
                    
                    if openInfo.count == 0{
                        cell.firstStack.isHidden = true
                    }else if openInfo.count == 1{
                        cell.firstStack.isHidden = false
                        cell.firstLabel.isHidden = true
                        cell.firstName1.text = openInfo[0].firstName
                        cell.firstView2.isHidden = true
                        cell.firstView3.isHidden = true
                    }else if openInfo.count == 2{
                        cell.firstStack.isHidden = false
                        cell.firstLabel.isHidden = true
                        cell.firstName1.text = openInfo[0].firstName
                        cell.firstName2.text = openInfo[1].firstName
                        cell.firstView3.isHidden = true
                    }else{
                        cell.firstStack.isHidden = false
                        cell.firstLabel.isHidden = true
                        cell.firstName1.text = openInfo[0].firstName
                        cell.firstName2.text = openInfo[1].firstName
                    }
                    
                    if middleInfo.count == 0{
                        cell.secondStack.isHidden = true
                    }else if middleInfo.count == 1{
                        cell.secondStack.isHidden = false
                        cell.secondLabel.isHidden = true
                        cell.secondName1.text = middleInfo[0].firstName
                        cell.secondView2.isHidden = true
                        cell.secondView3.isHidden = true
                    }else if middleInfo.count == 2{
                        cell.secondStack.isHidden = false
                        cell.secondLabel.isHidden = true
                        cell.secondName1.text = middleInfo[0].firstName
                        cell.secondName2.text = middleInfo[1].firstName
                        cell.secondView3.isHidden = true
                    }else{
                        cell.secondStack.isHidden = false
                        cell.secondLabel.isHidden = true
                        cell.secondName1.text = middleInfo[0].firstName
                        cell.secondName2.text = middleInfo[1].firstName
                    }
                    
                    if closeInfo.count == 0{
                        cell.thirdStack.isHidden = true
                    }else if closeInfo.count == 1{
                        cell.thirdStack.isHidden = false
                        cell.thirdLabel.isHidden = true
                        cell.thirdName1.text = closeInfo[0].firstName
                        cell.thirdView2.isHidden = true
                        cell.thirdView3.isHidden = true
                    }else if closeInfo.count == 2{
                        cell.thirdStack.isHidden = false
                        cell.thirdLabel.isHidden = true
                        cell.thirdName1.text = closeInfo[0].firstName
                        cell.thirdName2.text = closeInfo[1].firstName
                        cell.thirdView3.isHidden = true
                    }else{
                        cell.thirdStack.isHidden = false
                        cell.thirdLabel.isHidden = true
                        cell.thirdName1.text = closeInfo[0].firstName
                        cell.thirdName2.text = closeInfo[1].firstName
                    }
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerMainTableViewCell") as? HomeManagerMainTableViewCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    if let data = todayInfo{
                        cell.dateLabel.text = "\(data.month!)/\(data.date!) \(data.day!)요일"
                    }
                    switch status {
                    case 0: // 근무전
                        cell.heightConstraint.constant = 71
                        cell.honeyImage.image = #imageLiteral(resourceName: "imgHoneyReady")
                        cell.btnAddWork.setTitle("업무추가", for: .normal)
                        cell.titleLabel.text = "오픈 준비중 이에요."
                        cell.btnAddWork.isHidden = false
                    case 2: // 근무 후
                        cell.heightConstraint.constant = 71
                        cell.honeyImage.image = #imageLiteral(resourceName: "imgHoneyDone")
                        cell.btnAddWork.setTitle("완료한 업무", for: .normal)
                        cell.titleLabel.text = "마감 됐어요."
                        cell.btnAddWork.isHidden = false
                    default: // 3 휴무
                        cell.heightConstraint.constant = 91
                        cell.honeyImage.image = #imageLiteral(resourceName: "imgHoneySleeping")
                        cell.btnAddWork.isHidden = true
                        cell.titleLabel.text = "오늘은 휴무일이에요."
                    }
                    return cell
                }
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerCommunityTableViewCell") as? HomeManagerCommunityTableViewCell {
                cell.delegate = self
                if let data = boardInfo{
                    cell.setCell(boardInfo: data)
                }
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
            return 163
       
        default:
            return 0
        }
    }
}

extension HomeManagerVC: HomeManagerOpenDeleagate, HomeManagerAddWorkDelegate{
    //오늘 근무자 창
    func goTodayWorkerList() {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerWorkerTodayWorkerListVC") as? HomeManagerWorkerTodayWorkerListVC else {return}
       
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
    //완료한 업무 버튼 or 공동업무 추가 페이지
    
    func goAddWorkPage() {
        
        if status == 2{ //완료한 업무
            //공동 업무 상세 페이지로
            print("goPublicWork")
            
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkVC") as? HomeManagerTodayWorkVC else {return}
            nextVC.segValue = 0
            nextVC.status = status
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else if status == 0 { //업무 추가
            //공동 업무 추가 페이지로
            print("goAddPublicWork")
            
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAddPublicWorkVC") as? HomeManagerAddPublicWorkVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        /*
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeManagerAddWorkVC") as? HomeManagerAddWorkVC {
            vc.modalPresentationStyle = .overFullScreen
            
            //modalBgView.alpha = 1
            //vc.delegate = self
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }*/
    }
    
    // 공동 업무 상세
    func goPublicWork() {
        print("goPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkVC") as? HomeManagerTodayWorkVC else {return}
        nextVC.segValue = 0
        nextVC.status = status
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    // 개인 업무 상세
    func goPrivateWork() {
        print("goPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkVC") as? HomeManagerTodayWorkVC else {return}
        nextVC.segValue = 1
        nextVC.status = status
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension HomeManagerVC: HomeManagerAddWorkSelectDelegate{
    // 공동업무 추가 페이지로
    func goAddPublicWork() {
        print("goAddPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAddPublicWorkVC") as? HomeManagerAddPublicWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    // 개인 업무 추가 페이지로
    func goAddPrivateWork() {
        print("goAddPrivateWork()")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAddPrivateWorkVC") as? HomeManagerAddPrivateWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension HomeManagerVC {
    func didSuccessHomeManager(result: HomeManagerResponse) {
        
        
        homeManagerData = result.data
        if let data = homeManagerData{
            todayInfo = data.todayInfo
            shopInfo = data.shopInfo
            workerInfo = data.workerInfo
            taskInfo = data.taskInfo
            boardInfo = data.boardInfo
            //status 설정
            status = (shopInfo!.status!)
            if status == 1{
                isOpen = true
            }else{
                isOpen = false
            }
            storeNameLabel.text = shopInfo!.name!
            
        }
        print(homeManagerData)
        setUI()
        //오픈 미들 마감 선별
        openInfo.removeAll()
        middleInfo.removeAll()
        closeInfo.removeAll()
        var i = 0
        if let data = workerInfo{
            while(i < data.count){
                if data[i].title!.contains("오픈"){
                    openInfo.append(data[i])
                }else if data[i].title!.contains("미들"){
                    middleInfo.append(data[i])
                }else{
                    closeInfo.append(data[i])
                }
                i += 1
            }
        }
        //isOpen = true
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestHomeManager(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}


//HomeManagerClearAlertVC
