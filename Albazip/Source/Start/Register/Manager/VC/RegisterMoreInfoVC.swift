//
//  RegisterMoreInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
import UIKit
import Then
import SnapKit

class RegisterMoreInfoVC: UIViewController, StoreClosedDayDelegate {
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnNext: UIButton!
    
    
    // 버튼 선택 정보 저장
    var btnArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    // 순서) 연중 무휴, 월-금, 휴무일
    // enable:0, selected:1, disabled: 2
//    var workHourArr = [WorkHour]()
//    var holiday = [String]()
    var salaryDate = ""
    // Datamanager
    lazy var dataManager: RegisterManagerDataManager = RegisterManagerDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
//        let registerManagerInfo = RegisterManagerInfo.shared
//        if let workHour = registerManagerInfo.workHour{
//            workHourArr = workHour
//            tableView.reloadData()
//        }
        checkValue()
    }
    
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StoreClosedDayCell", bundle: nil),
                           forCellReuseIdentifier: "StoreClosedDayCell")
    }
    @objc func selectSalaryDate(_ sender: UIButton) {

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectSalaryDateVC") as? RegisterSelectSalaryDateVC {
            vc.modalPresentationStyle = .overFullScreen

            modalBgView.isHidden = false
            vc.salaryModalDelegate = self

            self.present(vc, animated: true, completion: nil)

        }

    }

    //모든 값을 다 입력했는지 검사
    func checkValue(){
        if btnArray.contains(1), salaryDate != ""{
            btnNext.isEnabled = true
            btnNext.backgroundColor = .enableYellow
            btnNext.setTitleColor(.gray, for: .normal)
        }else{
            btnNext.isEnabled = false
            btnNext.backgroundColor = .disableYellow
            btnNext.setTitleColor(.semiGray, for: .normal)
        }
    }
   
    // 휴무일 추가
//    func setHoliday(){
//        holiday.removeAll()
//        for i in 0..<btnArray.count{
//            if btnArray[i] == 1{
//                holiday.append(dayOfIndex(index: i))
//            }
//        }
//    }
    
    func dayOfIndex(index :Int) -> String{
        switch (index){
            case 0: return "연중무휴"
            case 1: return "월"
            case 2 : return "화"
            case 3 : return "수"
            case 4: return "목"
            case 5 : return "금"
            case 6 : return "토"
            case 7: return "일"
            default: return "공휴일"
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func btnDayClicked(index: Int) {
        switch (index){
        case 0:
            if btnArray[index] == 0{
                btnArray[index] = 1
                for i in 1...8{
                    btnArray[i] = 2
                }
            }else if btnArray[index] == 1{
                btnArray[index] = 0
                for i in 1...8{
                    btnArray[i] = 0
                }
            }
            break
            
        default:
            if btnArray[index] == 0{
                btnArray[index] = 1
                btnArray[0] = 2
            }else if btnArray[index] == 1{
                btnArray[index] = 0
                if !btnArray.contains(1){
                    btnArray[0] = 0
                }
            }
            break
        }
        checkValue()
        tableView.reloadData()
    }
    
    @objc func goStoreHourPage(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterStoreHourVC") as? RegisterStoreHourVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        // 기존 입력 값 불러오기
        let data = RegisterManagerInfo.shared

        //로그인화면에서 포지션 선택으로 온것인지 관리자 가입에서 온것인지 잘 판단해야할듯, => 둘다 토큰을 Userdault말고 RegisterBasicInfo에 저장하자!
        
        // 휴무일 설정
//        setHoliday()
        
        // 영업시간 설정
        var openSchedule = [OpenSchedule]()
//        for (i, _) in workHourArr.enumerated(){
//            //시간에서 : 문자 제거
//            let startStr = workHourArr[i].startTime.replace(target: ":", with: "")
//            let endStr = workHourArr[i].endTime.replace(target: ":", with: "")
//
//            openSchedule.append(OpenSchedule(startTime: startStr, endTime: endStr, day: workHourArr[i].day))
//        }
        
        // api resquest 데이터
//        let input = RegisterManagerRequset(name: data.name!, type: data.type!, address: data.address!, registerNumber: data.registerNumber!, openSchedule: openSchedule, holiday: holiday, payday: salaryDate)
//        print(input)
//
//        // api 통신
//        dataManager.postRegisterManager(input, delegate: self)

        //휴무일 정보 reset
//        holiday.removeAll()
    }
}
extension RegisterMoreInfoVC: SalaryModalDelegate {
    
    func modalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }

    func textFieldData(data: String) {
        salaryDate = data
        tableView.reloadData()
    }
}

extension RegisterMoreInfoVC {
    func didSuccessRegisterManager(_ result: RegisterManagerResponse) {
        
        //우선 유저 토큰 로컬에 저장
        UserDefaults.standard.set(result.data?.token ,forKey: "token")
        print("token: \(UserDefaults.standard.string(forKey: "token")!)")
        UserDefaults.standard.set(1 ,forKey: "job")
        print("job: \(UserDefaults.standard.string(forKey: "job")!)")
        // 온보딩 페이지로 이동
        let newStoryboard = UIStoryboard(name: "OnboardingManagerStoryboard", bundle: nil)
                    let newViewController = newStoryboard.instantiateViewController(identifier: "OnboardingManagerVC")
        self.changeRootViewController(newViewController)
        
    }
    
    func failedToRegisterManager(message: String) {
        self.presentAlert(title: message)
    }
}

// 테이블뷰 extension
extension RegisterMoreInfoVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return CGFloat.leastNonzeroMagnitude
        }else{
            return 57
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        let sectionTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            $0.textColor = UIColor(hex: 0x6f6f6f)
        }
        
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(36)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        if section == 1{
            sectionTitle.text = "영업시간"
        }else if section == 2{
            sectionTitle.text = "급여일"
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = UITableViewCell()
            let titleLabel = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                $0.textColor = UIColor(hex: 0x343434)
            }
            cell.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview().inset(36)
                $0.height.equalTo(29)
            }
            titleLabel.text = "추가 정보를 입력해주세요."
            return cell
        }else if indexPath.section == 1{ // 1. 영업 시간
            let cell = UITableViewCell()
            
            let hourBtn = UIButton().then{
                $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                $0.setTitle("영업시간 설정하기", for: .normal)
                $0.layer.cornerRadius = 10
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
            }
            cell.contentView.addSubview(hourBtn)
            hourBtn.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.trailing.leading.equalToSuperview().inset(36)
            }
            
            hourBtn.addTarget(self, action: #selector(goStoreHourPage(_:)), for: .touchUpInside)
            
            return cell
        }else if indexPath.section == 2{ // 2. 급여일
            let cell = UITableViewCell()
            let payDayBtn = UIButton().then{
                $0.layer.cornerRadius = 10
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                $0.tag = indexPath.row
            }
            let everyMonth = UILabel().then{
                $0.textColor = UIColor(hex: 0x6f6f6f)
                $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                $0.text = "매월"
            }
            let everyDay = UILabel().then{
                $0.textColor = UIColor(hex: 0x6f6f6f)
                $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                $0.text = "일"
            }
            let payDayLabel = UILabel().then{
                if salaryDate == ""{
                    $0.textColor = UIColor(hex: 0xc8c8c8)
                    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                    $0.text = "1 - 31"
                }else{
                    $0.textColor = UIColor(hex: 0x343434)
                    $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                    $0.text = salaryDate
                }
                $0.textAlignment = .right
            }
            cell.addSubview(payDayLabel)
            cell.addSubview(everyMonth)
            cell.addSubview(everyDay)
            cell.contentView.addSubview(payDayBtn)
            payDayLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(74)
                $0.leading.equalToSuperview().inset(92)
            }
            everyMonth.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(52)
            }
            everyDay.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(52)
            }
            payDayBtn.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.trailing.leading.equalToSuperview().inset(36)
            }
            
            payDayBtn.addTarget(self, action: #selector(selectSalaryDate(_:)), for: .touchUpInside)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 29
        }else if indexPath.section == 1{
            return 39
        }else{
            return 45
        }
    }
}
