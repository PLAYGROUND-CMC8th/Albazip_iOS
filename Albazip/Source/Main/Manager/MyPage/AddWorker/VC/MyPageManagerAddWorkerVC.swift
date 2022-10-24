//
//  MyPageManagerAddWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import Foundation
import UIKit

enum WriteType:Int {
    case add // 작성
    case edit // 편집
}

class MyPageManagerAddWorkerVC: UIViewController{
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tableView: UITableView!
    
    // 폼 타입
    var writeType: WriteType = .add
    
    // 수정 모드
    var positionId: Int?
    lazy var dataManager: MyPageManagerEditWorkerDatamanager = MyPageManagerEditWorkerDatamanager()

    // 폼 요소 다 채워졌는지 확인
    var checkValue3 = true
    
    // data
    var loadData : MyPageManagerEditWorkerData?
    var salaryType = "시급"
    
    var positionDay = ""{
        didSet{
            reloadSection(section: 0)
        }
    }
    
    var positionHour = ""{
        didSet{
            reloadSection(section: 0)
        }
    }
    
    var breakTime = ""{
        didSet{
            reloadSection(section: 1)
        }
    }
    
    var salary = "8720"
    
    var isWorkDaySetted = false{
        didSet{
            if isWorkDaySetted{
                reloadSection(section: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
        setData()
        setNoti()
        if writeType == .edit{
            showIndicator()
            dataManager.getMyPageManagerEditWorker(vc: self, index: positionId ?? 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if writeType == .add{
            let workerInfo = MyPageManagerAddWorkerInfo.shared
            if workerInfo.workSchedule != nil{
                isWorkDaySetted = true
            }else{
                isWorkDaySetted = false
            }
            checkValue()
        }
    }
    
    //MARK:- View Setup
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
        btnNext.isEnabled = false
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo3TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
    }
    
    func setData(){
        // 싱글톤 초기화
        let workerInfo = MyPageManagerAddWorkerInfo.shared
        workerInfo.workSchedule = nil
    }
    
    func setNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let data = MyPageManagerAddWorkerInfo.shared
        data.salaryType = salaryType
        data.salary = salary
        data.breakTime = breakTime
        data.title = positionDay + positionHour
        
        if let positionId = self.positionId{ // 수정모드
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
        }else{ // 작성모드
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageManagerWorkListVC") as? MyPageManagerWorkListVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    //모든 값이 입력되었는지 확인
    func checkValue(){
        if positionHour != "", positionDay != "", checkValue3, isWorkDaySetted, breakTime != ""{
            btnNext.isEnabled = true
            btnNext.setTitleColor(#colorLiteral(red: 0.9961670041, green: 0.7674626112, blue: 0, alpha: 1), for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    
    @objc func goSelectWorkHourPage(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SelectWorkerHourVC") as? SelectWorkerHourVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func positionDayBtnTapped(_ sender: UIButton){
        if sender.tag == 0{
            positionDay = "평일"
        }else{
            positionDay = "주말"
        }
        checkValue()
    }
    
    @objc func positionHourBtnTapped(_ sender: UIButton){
        if sender.tag == 2{
            positionHour = "오픈"
        }else if sender.tag == 3{
            positionHour = "미들"
        }else if sender.tag == 4{
            positionHour = "마감"
        }
        checkValue()
    }
    
    @objc func breakTimeBtnTapped(_ sender: UIButton){
        if sender.tag == 0{
            breakTime = "없음"
        }else if sender.tag == 1{
            breakTime = "30분"
        }else if sender.tag == 2{
            breakTime = "60분"
        }else{
            breakTime = "90분"
        }
        checkValue()
    }
    
    @objc override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc override func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Selected 버튼
    func btnSelected(btn: UIButton){
        btn.setTitleColor(#colorLiteral(red: 0.203897506, green: 0.2039385736, blue: 0.2081941962, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.borderColor =  #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.isSelected = true
    }
    
    //UnSelected 버튼
    func btnUnSelected(btn: UIButton){
        btn.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
        btn.backgroundColor = .none
        btn.borderColor =  #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.isSelected = false
    }
    
    func reloadSection(section: Int){
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(section...section), with: .none)
        tableView.endUpdates()
    }
}
//MARK:- Table View Data Source

extension MyPageManagerAddWorkerVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 104
        
        case 1:
            if indexPath.row == 0{
                return 118
            }else{
                return 75
            }
            
        case 2:
            return 57
            
        default:
          return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 78
        }else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        // 섹션 title
        let sectionTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(hex: 0x000000)
        }
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(36)
            $0.height.equalTo(19)
        }
        
        switch section{
        case 0:
            sectionTitle.text = "포지션 선택하기"
        case 1:
            sectionTitle.text = "스케줄 입력하기"
        case 2:
            sectionTitle.text = "급여 입력하기"
        default:
            break
        }
        
        if section == 0{
            // 섹션 subTitle
            let sectionSubTitle = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                $0.textColor = UIColor(hex: 0xA3A3A3)
                $0.text = "포지션이 여러개라면, 메인 포지션을 선택해 주세요."
            }
            sectionView.addSubview(sectionSubTitle)
            
            sectionSubTitle.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(24)
                $0.top.equalTo(sectionTitle.snp.bottom).offset(6)
                $0.height.equalTo(17)
            }
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            let dayStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.distribution = .fillEqually
                $0.alignment = .center
                $0.spacing = 8
            }
            let hourStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.distribution = .fillEqually
                $0.alignment = .center
                $0.spacing = 8
            }

            cell.contentView.addSubview(dayStackView)
            cell.contentView.addSubview(hourStackView)
            
            dayStackView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(12)
                $0.leading.equalToSuperview().inset(24)
                $0.height.equalTo(41)
            }
            
            hourStackView.snp.makeConstraints {
                $0.top.equalTo(dayStackView.snp.bottom).offset(10)
                $0.leading.equalToSuperview().inset(24)
                $0.height.equalTo(41)
            }
            
            for i in 0..<5{
                let selectBtn = UIButton().then{
                    $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                    $0.layer.cornerRadius = 16
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                    $0.tag = i
                }
                var titleText = ""
                switch (i){
                case 0:
                    titleText = "평일"
                case 1:
                    titleText = "주말"
                case 2:
                    titleText = "오픈"
                case 3:
                    titleText = "미들"
                default:
                    titleText = "마감"
                }
                selectBtn.setTitle(titleText, for: .normal)
                
                if i<2{
                    dayStackView.addArrangedSubview(selectBtn)
                    selectBtn.addTarget(self, action: #selector(positionDayBtnTapped(_:)), for: .touchUpInside)
                    if positionDay == titleText{
                        btnSelected(btn: selectBtn)
                    }else{
                        btnUnSelected(btn: selectBtn)
                    }
                }else{
                    hourStackView.addArrangedSubview(selectBtn)
                    selectBtn.addTarget(self, action: #selector(positionHourBtnTapped(_:)), for: .touchUpInside)
                    if positionHour == titleText{
                        btnSelected(btn: selectBtn)
                    }else{
                        btnUnSelected(btn: selectBtn)
                    }
                }
                selectBtn.snp.makeConstraints {
                    $0.height.equalTo(41)
                    $0.width.equalTo(53)
                }
            }
            
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = UITableViewCell()
                
                // 근무일
                let titleLabel = UILabel().then{
                    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                    $0.textColor = UIColor(hex: 0x6f6f6f)
                    $0.text = "근무일"
                }
                
                cell.addSubview(titleLabel)
                
                titleLabel.snp.makeConstraints {
                    $0.leading.equalToSuperview().inset(24)
                    $0.top.equalToSuperview().inset(12)
                    $0.height.equalTo(19)
                }
                
                // 입력 완료 표시
                let completedLabel = UILabel().then{
                    $0.textColor = UIColor(hex: 0x1dbe4e)
                    $0.text = "설정 완료"
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                }
                cell.addSubview(completedLabel)
                
                completedLabel.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
                }
                let completedImage = UIImageView().then{
                    $0.image = UIImage(named: "icCheckedCorrect")
                }
                
                cell.addSubview(completedImage)
                
                completedImage.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.leading.equalTo(completedLabel.snp.trailing)
                    $0.height.width.equalTo(18)
                }
                
                if isWorkDaySetted{
                    completedImage.isHidden = false
                    completedLabel.isHidden = false
                }else{
                    completedImage.isHidden = true
                    completedLabel.isHidden = true
                }
                
                let hourBtn = UIButton().then{
                    $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    if isWorkDaySetted{
                        $0.setTitle("근무일 변경하기", for: .normal)
                    }else{
                        $0.setTitle("근무일 설정하기", for: .normal)
                    }
                    $0.layer.cornerRadius = 10
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                }
                cell.contentView.addSubview(hourBtn)
                hourBtn.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(14)
                    $0.height.equalTo(40)
                    $0.trailing.leading.equalToSuperview().inset(24)
                }
                
                hourBtn.addTarget(self, action: #selector(goSelectWorkHourPage(_:)), for: .touchUpInside)
                
                return cell
            }else{
                let cell = UITableViewCell()
                // 쉬는 시간
                let titleLabel = UILabel().then{
                    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                    $0.textColor = UIColor(hex: 0x6f6f6f)
                    $0.text = "쉬는 시간"
                }
                
                cell.addSubview(titleLabel)
                
                titleLabel.snp.makeConstraints {
                    $0.leading.equalToSuperview().inset(24)
                    $0.top.equalToSuperview()
                    $0.height.equalTo(19)
                }
                let subLabel = UILabel().then{
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                    $0.textColor = UIColor(hex: 0xA3A3A3)
                    $0.text = "근무일 4시간 이상부터 적용"
                }
                
                cell.addSubview(subLabel)
                
                subLabel.snp.makeConstraints {
                    $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
                    $0.centerY.equalTo(titleLabel.snp.centerY)
                }
                
                let breakTimeStackView = UIStackView().then {
                    $0.axis = .horizontal
                    $0.distribution = .fillEqually
                    $0.alignment = .center
                    $0.spacing = 8
                }

                cell.contentView.addSubview(breakTimeStackView)
                
                breakTimeStackView.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(14)
                    $0.leading.equalToSuperview().inset(24)
                    $0.height.equalTo(41)
                }
                
                for i in 0..<4{
                    let selectBtn = UIButton().then{
                        $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                        $0.layer.cornerRadius = 16
                        $0.layer.borderWidth = 1
                        $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                        $0.tag = i
                    }
                    var titleText = ""
                    switch (i){
                    case 0:
                        titleText = "없음"
                    case 1:
                        titleText = "30분"
                    case 2:
                        titleText = "60분"
                    default:
                        titleText = "90분"
                    }
                    selectBtn.setTitle(titleText, for: .normal)
                    

                    breakTimeStackView.addArrangedSubview(selectBtn)
                    selectBtn.addTarget(self, action: #selector(breakTimeBtnTapped(_:)), for: .touchUpInside)
                    if breakTime == titleText{
                        btnSelected(btn: selectBtn)
                    }else{
                        btnUnSelected(btn: selectBtn)
                    }
                    
                    selectBtn.snp.makeConstraints {
                        $0.height.equalTo(41)
                        $0.width.equalTo(53)
                    }
                }
                return cell
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo3TableViewCell") as? MyPageManagerSelectInfo3TableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                cell.myPageManagerPayTypeModalDelegate = self
                if salaryType != ""{
                    cell.payTypeLabel.text = salaryType
                    
                }
                
                if writeType == .edit{
                    cell.moneyTextField.text = salary
                }
                
                salary = cell.moneyTextField.text!
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension MyPageManagerAddWorkerVC: SelectPayTypeDelegate {
    func modalDismiss(){
        modalBgView.isHidden = true
    }
    func textFieldData(data: String){
        salaryType = data
        tableView.reloadData()
    }
}

extension MyPageManagerAddWorkerVC:  MyPageManagerPayTypeModalDelegate{

    func checkValue3(text: String) {
        print("salary: "+text)
        salary = text
        if text != ""{
            checkValue3 = true
        }else{
            checkValue3 = false
        }
        checkValue()
    }
    
    //급여 계산 기준 선택 페이지로
    func goSelectPayType() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageManagerSelectPayTypeVC") as? MyPageManagerSelectPayTypeVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
                    modalBgView.isHidden = false
                    vc.selectPayTypeDelegate = self
                    self.view.endEditing(true)
                    self.present(vc, animated: true, completion: nil)
        }
    }
}

extension MyPageManagerAddWorkerVC {
    func didSuccessMyPageMyPageManagerEditWorker(_ result: MyPageManagerEditWorkerResponse) {
        dismissIndicator()

        let data = MyPageManagerAddWorkerInfo.shared
        guard let response = result.data else {return}
        
        // 전체 데이터 저장
        self.loadData = response
        
        // 급여 타입
        self.salaryType = {
            switch(response.salaryType){
            case 0:
                return "시급"
            case 1:
                return "주급"
            default:
                return "월급"
            }
        }()
        data.salaryType = self.salaryType
        
        // 급여
        self.salary = response.salary
        data.salary = self.salary
        reloadSection(section: 2)
        
        // 쉬는 시간
        self.breakTime = response.breakTime
        data.breakTime = self.breakTime
        
        // 포지션
        self.positionDay = response.title.substring(from: 0, to: 2)
        self.positionHour = response.title.substring(from: 2, to: 4)
        data.title = positionDay + positionHour
        
        // 근무 시간
        var workHourArr = [WorkHour]()
        var workDayTypes = [Bool]()
        
        for i in 0...6{
            var appended = false
            for work in response.workSchedule{
                if SysUtils.dayOfIndex(index: i) == work.day{
                    workHourArr.append(WorkHour(
                        startTime: work.startTime?.insertTime,
                        endTime: work.endTime?.insertTime,
                        day: work.day
                    ))
                    workDayTypes.append(true)
                    appended = true
                    break
                }
            }
            if !appended{
                workHourArr.append(WorkHour(
                    startTime: nil,
                    endTime: nil,
                    day: SysUtils.dayOfIndex(index: i)
                ))
                workDayTypes.append(false)
            }
        }
        data.workSchedule = workHourArr
        data.workDayTypes = workDayTypes
        
        isWorkDaySetted = true
        checkValue()
        writeType = .add
    }
    
    func failedToRequestMyPageManagerEditWorker(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)
    }
}
