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
    
    
//    @IBOutlet var startTextField: UITextField!
//    @IBOutlet var endTextField: UITextField!
//
//    @IBOutlet var salaryTextField: UITextField!
//    @IBOutlet var hourLabel: UILabel!
    
    @IBOutlet var btnNext: UIButton!
    
    
    // 버튼 선택 정보 저장
    var btnArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    // 순서) 연중 무휴, 월-금, 휴무일
    // enable:0, selected:1, disabled: 2
    
    var holiday = [String]()
    var salaryDate = ""
    // Datamanager
    lazy var dataManager: RegisterManagerDataManager = RegisterManagerDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
//        salaryTextField.addRightPadding()
//        modalBgView.isHidden = true
//        salaryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
//        startTextField.addLeftPadding()
//        endTextField.addLeftPadding()
//        startTextField.addTarget(self, action: #selector(startTimeTextFieldDidChange(_:)), for: .touchDown)
//        endTextField.addTarget(self, action: #selector(endTimeTextFieldDidChange(_:)), for: .touchDown)
//        salaryTextField.attributedPlaceholder = NSAttributedString(string: "1 - 31    ", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
//        startTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 30)!])
//        endTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 30)!])
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
    
//    @objc func startTimeTextFieldDidChange(_ textField:UITextField) {
//
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
//            vc.modalPresentationStyle = .overFullScreen
//
//            modalBgView.isHidden = false
//            vc.timeDateModalDelegate = self
//            vc.whatDate = 0
//            vc.titletext = "매장 오픈 시간"
//            self.present(vc, animated: true, completion: nil)
//
//        }
//    }
//    @objc func endTimeTextFieldDidChange(_ textField:UITextField) {
//
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
//            vc.modalPresentationStyle = .overFullScreen
//
//            modalBgView.isHidden = false
//            vc.timeDateModalDelegate = self
//            vc.whatDate = 1
//            vc.titletext = "매장 마감 시간"
//            self.present(vc, animated: true, completion: nil)
//
//        }
//    }
    
    
    
//    func checkBtn(){
//        if !btnMon.isSelected, !btnTue.isSelected, !btnWed.isSelected, !btnThu.isSelected, !btnFri.isSelected, !btnSat.isSelected, !btnSun.isSelected, !btnBreak.isSelected{
//            enableBtn(btn: btnNoBreak)
//        }
//    }
//    //모든 값을 다 입력했는지 검사
//    func checkValue(){
//        print(startTextField.text!)
//
//        if startTextField.text != "" && endTextField.text != "" && salaryTextField.text != ""{
//            if btnNoBreak.isSelected{
//                //연중무휴 체크
//                btnNext.isEnabled = true
//                btnNext.backgroundColor = .enableYellow
//                btnNext.setTitleColor(.gray, for: .normal)
//            }else if !btnMon.isSelected, !btnTue.isSelected, !btnWed.isSelected, !btnThu.isSelected, !btnFri.isSelected, !btnSat.isSelected, !btnSun.isSelected, !btnBreak.isSelected{
//                // 아무것도 체크 안됨
//                btnNext.isEnabled = false
//                btnNext.backgroundColor = .disableYellow
//                btnNext.setTitleColor(.semiGray, for: .normal)
//            }else{
//                //버튼중에 하나는 선택되어있음
//                btnNext.isEnabled = true
//                btnNext.backgroundColor = .enableYellow
//                btnNext.setTitleColor(.gray, for: .normal)
//            }
//        }else{
//            btnNext.isEnabled = false
//            btnNext.backgroundColor = .disableYellow
//            btnNext.setTitleColor(.semiGray, for: .normal)
//        }
//    }
    
    //시간차 구하기
//    func calculateTime(){
//        if startTextField.text!.count > 0, endTextField.text!.count > 0{
//            let startTime = startTextField.text!.components(separatedBy: ":")
//            let endTime = endTextField.text!.components(separatedBy: ":")
//            var startTotal = 0
//            var endTotal = 0
//            var hour = 0
//            var minute = 0
//
//            //마감시간이 오픈시간 값보다 작을 때 마감시간에 24더하고 빼주기
//            if Int(startTime[0])!>Int(endTime[0])!{
//                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
//            }else if Int(startTime[0])!==Int(endTime[0])! , Int(startTime[1])!>Int(endTime[1])!{
//                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
//            }
//            //오픈 시간보다 마감시간이 더 빠를때!
//            else{
//                endTotal = Int(endTime[0])! * 60 + Int(endTime[1])!
//            }
//            startTotal = Int(startTime[0])! * 60 + Int(startTime[1])!
//
//            let diffTime = endTotal - startTotal
//            hour = diffTime/60
//            minute = diffTime%60
//
//            hourLabel.text = "\(hour)시간\(minute)분"
//        }
//    }
    
//    //휴일 정보를 배열에 저장
//    func getHoliday(){
//        //연중 무휴가 아닐때 배열에 추가
//        if !btnNoBreak.isSelected{
//            if btnMon.isSelected{
//                holiday.append("월")
//            }
//            if btnTue.isSelected{
//                holiday.append("화")
//            }
//            if btnWed.isSelected{
//                holiday.append("수")
//            }
//            if btnThu.isSelected{
//                holiday.append("목")
//            }
//            if btnFri.isSelected{
//                holiday.append("금")
//            }
//            if btnSat.isSelected{
//                holiday.append("토")
//            }
//            if btnSun.isSelected{
//                holiday.append("일")
//            }
//            if btnBreak.isSelected{
//                holiday.append("공휴일")
//            }
//        }else{
//            holiday.append("연중무휴")
//        }
//    }
    
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
//        checkValue()
        tableView.reloadData()
    }
    
    @objc func goStoreHourPage(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterStoreHourVC") as? RegisterStoreHourVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
//    @IBAction func btnNext(_ sender: Any) {
//        // 몇시간 몇분 시간 계산
//        holiday.removeAll()
//        // 휴무일 정보 불러오기
//        getHoliday()
//
//        // 기존 입력 값 불러오기
//        let data = RegisterManagerInfo.shared
//
//        //시간에서 : 문자 제거
//        let removeStartTime = startTextField.text!.replace(target: ":", with: "")
//        let removeEndTime = endTextField.text!.replace(target: ":", with: "")
//
//        //로그인화면에서 포지션 선택으로 온것인지 관리자 가입에서 온것인지 잘 판단해야할듯, => 둘다 토큰을 Userdault말고 RegisterBasicInfo에 저장하자!
//
//        // api resquest 데이터
//        let input = RegisterManagerRequset(name: data.name!, type: data.type!, address: data.address!, registerNumber: data.registerNumber!, startTime: removeStartTime, endTime: removeEndTime, breakTime: "0",holiday: holiday, payday: salaryTextField.text!)
//        print(input)
//
//        // api 통신
//        dataManager.postRegisterManager(input, delegate: self)
//
//        //휴무일 정보 reset
//        holiday.removeAll()
//    }
}
extension RegisterMoreInfoVC: SalaryModalDelegate {
    
    func modalDismiss() {
        modalBgView.isHidden = true
//        checkValue()
    }

    func textFieldData(data: String) {
        salaryDate = data
        tableView.reloadData()
    }
}

//extension RegisterMoreInfoVC: TimeDateModalDelegate {
    
//    func timeModalDismiss() {
//        modalBgView.isHidden = true
//        checkValue()
//    }
//
//    func openTimeTextFieldData(data: String) {
//        startTextField.text = data
//        calculateTime()
//    }
//    func endTimeTextFieldData(data: String) {
//        endTextField.text = data
//        calculateTime()
//    }
//}

//extension RegisterMoreInfoVC : UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if(textField == startTextField || textField == endTextField){
//                let newLength = (textField.text?.count)! + string.count - range.length
//                    return !(newLength > 4)
//            }
//
//            return true
//        }
//}

extension RegisterMoreInfoVC {
    func didSuccessRegisterManager(_ result: RegisterManagerResponse) {
        
        //
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
        return 4
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
            sectionTitle.text = "매장 휴무일"
        }else if section == 2{
            sectionTitle.text = "영업시간"
        }else if section == 3{
            sectionTitle.text = "급여일"
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 2
        }else{
            return 1
        }
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
        }else if indexPath.section == 1{ // 1. 매장 휴무일
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreClosedDayCell") as? StoreClosedDayCell {
                cell.selectionStyle = .none
                cell.delegate = self
                                cell.setUp(btnArray: self.btnArray)
                                return cell
                            }
        }else if indexPath.section == 2{ // 2. 영업 시간
            if indexPath.row == 0{
                let cell = UITableViewCell()
                let dayTotalView = UIView().then{
                    $0.backgroundColor = UIColor(hex: 0xf8f8f8)
                    $0.layer.cornerRadius = 10
                }
                let dayView = UIView().then{
                    $0.backgroundColor = .clear
                }
                let dayTitle = UILabel().then{
                    $0.textColor = UIColor(hex: 0x343434)
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                    $0.text = "월"
                }
                let dayTime = UILabel().then{
                    $0.textColor = UIColor(hex: 0x6f6f6f)
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                    $0.text = "10:00 ~ 17:00"
                    $0.textAlignment = .left
                }
                dayView.addSubview(dayTitle)
                dayView.addSubview(dayTime)
                
                dayTitle.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.leading.equalToSuperview().inset(16)
                }
                dayTime.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.leading.equalTo(dayTitle.snp.trailing).offset(8)
                }
                
                dayTotalView.addSubview(dayView)
                dayView.snp.makeConstraints {
                    $0.height.equalTo(40)
                    $0.top.bottom.trailing.leading.equalToSuperview()
                }
                cell.addSubview(dayTotalView)
                dayTotalView.snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.trailing.leading.equalToSuperview().inset(36)
                    $0.bottom.equalToSuperview().inset(12)
                }
                
                return cell
            }else{
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
            }
        }else if indexPath.section == 3{ // 3. 급여일
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
            return 90
        }else if indexPath.section == 2{
            if indexPath.row == 0{
                return tableView.estimatedRowHeight
            }else{
                return 39
            }
        }else{
            return 45
        }
    }
}
