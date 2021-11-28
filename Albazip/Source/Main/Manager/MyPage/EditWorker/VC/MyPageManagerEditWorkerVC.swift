//
//  MyPageManagerEditWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

import Foundation
class MyPageManagerEditWorkerVC: UIViewController{
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var modalBgView: UIView!
    
    //이전 데이터
    var loadData : MyPageManagerEditWorkerData?
    
    //최초 실행인지여부
    var isLoaded = false
    // 시간 변수
    var startTime = ""
    var endTime = ""
    var payTime = "시급"
    var hour = "0시간"
    // 테이블뷰 접었다 펴기
    var isDateSelected = true
    
    //폼 요소 다 채워졌는지 확인
    var checkValue1 = true
    var checkValue2 = true
    var checkValue3 = true
    
    // data
    var rank = ""
    var title2 = "" // 오픈 미들 마감
    var title3 = "" // 평일 주말
    var workDay = [String]()
    var breakTime = ""
    var salary = "8720"
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    
    // Datamanager
    lazy var dataManager: MyPageManagerEditWorkerDatamanager = MyPageManagerEditWorkerDatamanager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
        showIndicator()
        dataManager.getMyPageManagerEditWorker(vc: self, index: positionId)
    }
    //MARK:- View Setup
    func setUI(){
        //self.tabBarController?.tabBar.isHidden = true
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
        btnNext.isEnabled = false
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo1TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo3TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoHeightTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoHeightTableViewCell")
        
        //안내글
        tableView.register(UINib(nibName: "EditWorkerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "EditWorkerNoticeTableViewCell")
        //MyPageManagerNoHeightTableViewCell
        self.tableView.estimatedRowHeight = 1
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        let data = MyPageManagerAddWorkerInfo.shared
        data.startTime = startTime.replace(target: ":", with: "")
        data.endTime = endTime.replace(target: ":", with: "")
        data.salaryType = payTime
        data.salary = salary
        data.breakTime = breakTime
        data.title = title3 + title2
        data.rank = rank
        data.workDays = workDay
        
        print("data:\(data.rank) \(data.title) \(data.startTime) \(data.endTime) \(data.workDays) \(data.breakTime) \(data.salary) \(data.salaryType)")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageManagerEditWorkerListVC") as? MyPageManagerEditWorkerListVC else {return}
        if let data = loadData{
            var i = 0
            var editTaskList2 = [EditTaskLists2]()
            while i < data.taskList.count{
                editTaskList2.append(EditTaskLists2(title: data.taskList[i].title, content: data.taskList[i].content, id: data.taskList[i].id))
                i += 1
            }
            
            nextVC.taskList = editTaskList2
        }
        nextVC.positionId = positionId
                self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //모든 값이 입력되었는지 확인
    func checkContent(){
        if checkValue1, checkValue2, checkValue3, startTime != "", endTime != ""{
            
            btnNext.isEnabled = true
            btnNext.setTitleColor(#colorLiteral(red: 0.9961670041, green: 0.7674626112, blue: 0, alpha: 1), for: .normal)
            
        }else{
            btnNext.isEnabled = false
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    //시간차 구하기
    func calculateTime(){
        if startTime != "", endTime != "" {
            let startTime = startTime.components(separatedBy: ":")
            let endTime = endTime.components(separatedBy: ":")
            var startTotal = 0
            var endTotal = 0
            var hour = 0
            var minute = 0
            
            //마감시간이 오픈시간 값보다 작을 때 마감시간에 24더하고 빼주기
            if Int(startTime[0])!>Int(endTime[0])!{
                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
            }else if Int(startTime[0])!==Int(endTime[0])! , Int(startTime[1])!>Int(endTime[1])!{
                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
            }
            //오픈 시간보다 마감시간이 더 빠를때!
            else{
                endTotal = Int(endTime[0])! * 60 + Int(endTime[1])!
            }
            startTotal = Int(startTime[0])! * 60 + Int(startTime[1])!
            
            let diffTime = endTotal - startTotal
            hour = diffTime/60
            minute = diffTime%60
            
            self.hour  = "\(hour)시간\(minute)분"
        }
    }
}
//MARK:- Table View Data Source

extension MyPageManagerEditWorkerVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EditWorkerNoticeTableViewCell") as? EditWorkerNoticeTableViewCell {
                cell.selectionStyle = .none
                
                
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo1TableViewCell") as? MyPageManagerSelectInfo1TableViewCell {
                cell.selectionStyle = .none
                cell.myPageManagerSelectInfo1Delegate = self
                if !isLoaded{
                    if let data = loadData{
                        cell.setCell(data: data)
                    }
                }
                return cell
            }
        case 2:
            if isDateSelected{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo2TableViewCell") as? MyPageManagerSelectInfo2TableViewCell {
                    cell.selectionStyle = .none
                    if !isLoaded{
                        if let data = loadData{
                            cell.setCell(data: data)
                        }
                    }
                    cell.myPageManagerTimeDateModalDelegate = self
                    if startTime != ""{
                        cell.startButton.setTitle(startTime, for: .normal)
                        cell.startButton.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
                    }
                    if endTime != ""{
                        cell.endButton.setTitle(endTime, for: .normal)
                        cell.endButton.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
                    }
                    cell.hourLabel.text = self.hour
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoHeightTableViewCell") as? MyPageManagerNoHeightTableViewCell {
                    cell.selectionStyle = .none
                    
                    print(indexPath.row)
                    return cell
                }
            }
            
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo3TableViewCell") as? MyPageManagerSelectInfo3TableViewCell {
                cell.selectionStyle = .none
                if !isLoaded{
                    if loadData != nil{
                        cell.payTypeLabel.text = payTime
                        cell.moneyTextField.text = salary
                    }
                }
                print(indexPath.row)
                cell.myPageManagerPayTypeModalDelegate = self
                if payTime != ""{
                    cell.payTypeLabel.text = payTime
                    
                }
                salary = cell.moneyTextField.text!
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 71
        case 1:
            return 397
        
        case 2:
            if isDateSelected{
                return 269
            }else{
                return 1
            }
        case 3:
            return 208
        default:
            
        return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
}
extension MyPageManagerEditWorkerVC: TimeDateModalDelegate {
    func timeModalDismiss() {
        modalBgView.isHidden = true
        //checkValue()
    }

    func openTimeTextFieldData(data: String) {
        isLoaded = true
        startTime = data
        tableView.reloadData()
        calculateTime()
    }

    func endTimeTextFieldData(data: String) {
        isLoaded = true
        endTime = data
        tableView.reloadData()
        calculateTime()
    }
}

extension MyPageManagerEditWorkerVC: SelectPayTypeDelegate {
    func modalDismiss(){
        modalBgView.isHidden = true
    }
    func textFieldData(data: String){
        isLoaded = true
        payTime = data
        tableView.reloadData()
    }

    
}

extension MyPageManagerEditWorkerVC: MyPageManagerTimeDateModalDelegate, MyPageManagerPayTypeModalDelegate, MyPageManagerSelectInfo1Delegate{
    
    func setRank(text: String) {
        rank = text
        print("rank:\(rank)")
    }
    
    func setTitle(text: String) {
        title2 = text
        print("title:\(title2)")
    }
    func setTitle3(text: String){
        title3 = text
        print("title:\(title3)")
    }
    func setBreaktime(text: String) {
        breakTime = text
        print("breakTime:\(breakTime)")
    }
    func addDay(text: String) {
        workDay.append(text)
        print("workday:\(workDay)")
    }
    
    func deleteDay(text: String) {
        if let firstIndex = workDay.firstIndex(of: text) {
            workDay.remove(at: firstIndex)
        }
        print("workday:\(workDay)")
    }
    
    
    func checkValue1(value: Bool) {
        print(value)
        checkValue1 = value
        checkContent()
    }
    func checkValue2(value: Bool) {
        print(value)
        checkValue2 = value
        checkContent()
    }
    
    func checkValue3(text: String) {
        print("salary: "+text)
        salary = text
        if text != ""{
            checkValue3 = true
        }else{
            checkValue3 = false
        }
        checkContent()
    }
    func presentAlert(text: String) {
        presentBottomAlert(message: text)
    }
    
    func openView() {
        isLoaded = true
        isDateSelected = true
        tableView.reloadData()
    }
    
    func closeView() {
        isLoaded = true
        isDateSelected = false
        tableView.reloadData()
    }
    
    //타임 피커 페이지로..
    func goSelectTimeDate(index: Int) {
        print("goSelectTimeDate")
        let storyboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
                    modalBgView.isHidden = false
                    vc.timeDateModalDelegate = self
                    vc.whatDate = index
                    if index == 0{
                        vc.titletext = "출근 시간"
                    }else{
                        vc.titletext = "퇴근 시간"
                    }
                    self.present(vc, animated: true, completion: nil)
                    
                }
    }
    
    //급여 계산 기준 선택 페이지로
    func goSelectPayType() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageManagerSelectPayTypeVC") as? MyPageManagerSelectPayTypeVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
                    modalBgView.isHidden = false
                    vc.selectPayTypeDelegate = self
                    
                    self.present(vc, animated: true, completion: nil)
                    
        }
    }
    
    
}
extension MyPageManagerEditWorkerVC {
    func didSuccessMyPageMyPageManagerEditWorker(_ result: MyPageManagerEditWorkerResponse) {
        dismissIndicator()
        //self.presentAlert(title: result.message)
        print(result)
        loadData = result.data
        if let x = result.data{
            setRank(text: x.rank)
            //오픈 미들 마감
            if x.title.contains("오픈"){
                setTitle(text: "오픈")
            }else if x.title.contains("미들"){
                setTitle(text: "미들")
            }else{
                setTitle(text: "마감")
            }
            
            //평일 주말
            if x.title.contains("평일"){
                setTitle3(text: "평일")
            }else {
                setTitle3(text: "주말")
            }
            
            setBreaktime(text: x.breakTime)
            
            startTime = x.startTime.insertTime
            endTime = x.endTime.insertTime
            if x.salaryType == 0{
                payTime = "시급"
            }else if x.salaryType == 1{
                payTime = "주급"
            }else{
                payTime = "월급"
            }
            
            salary = x.salary
            workDay = x.workDay
        }
        btnNext.isEnabled = true
        tableView.reloadData()
        //isLoaded = true
    }
    
    func failedToRequestMyPageManagerEditWorker(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)
    }
}
