//
//  RegisterStoreHourVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/05/30.
//

import Foundation
import UIKit
import Then
import SnapKit

class RegisterStoreHourVC: UIViewController{
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextBtn: UIButton!
    
    var workHourArr = [WorkHour]()
    var storeHourTypeArr = [StoreHourType]()
    var hoilday : Set<String> = Set<String>()
    
    var isAllSameHour = false { // 모든 영업시간 일치 여부
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firebase.Log.signupOperatingTime.event()
        
        setUI()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let registerManagerInfo = RegisterManagerInfo.shared
        if let workHour = registerManagerInfo.workHour{
            workHourArr = workHour
            storeHourTypeArr = registerManagerInfo.storeHourType
            hoilday = registerManagerInfo.hoilday
            isAllSameHour = registerManagerInfo.allSameHour
        }else{
            initWorkHour()
        }
        checkValue()
    }
    
    func setUI(){
        modalBgView.isHidden = true
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AllHourSameCell.self, forCellReuseIdentifier: "AllHourSameCell")
        tableView.register(StoreHourTableViewCell.self, forCellReuseIdentifier: "StoreHourTableViewCell")
    }
    
    func initWorkHour(){
        for i in 0...6{
            workHourArr.append(WorkHour(startTime: nil, endTime: nil, day: SysUtils.dayOfIndex(index: i)))
            storeHourTypeArr.append(.normal)
        }
        isAllSameHour = false
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        for (index, value) in workHourArr.enumerated(){
            if !((storeHourTypeArr[index] == .normal) && (value.startTime == nil) && (value.endTime == nil)){
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreHourUnCompletedVC") as? StoreHourUnCompletedVC {
                    vc.modalPresentationStyle = .overFullScreen
                    vc.delegate = self
                    modalBgView.isHidden = false
                    self.present(vc, animated: true, completion: nil)
                }
                return
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.workHour = workHourArr
        registerManagerInfo.storeHourType = storeHourTypeArr
        registerManagerInfo.hoilday = hoilday
        registerManagerInfo.allSameHour = isAllSameHour
        self.navigationController?.popViewController(animated: true)
    }
   
    // 모든 요일 동일 버튼
    @objc func allSameBtnclicked(_ sender: UIButton){
        if isAllSameHour{
            isAllSameHour = false
            checkValue()
        }else{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectAllStoreHourVC") as? RegisterSelectAllStoreHourVC {
                vc.modalPresentationStyle = .overFullScreen
                vc.delegate = self
                vc.whatHour = .storeHour
                modalBgView.isHidden = false
                self.present(vc, animated: true, completion: nil)

            }
        }
    }
    
    // 휴무일 버튼
    @objc func holidayBtnclicked(_ sender: UIButton){
        if isAllSameHour{
            isAllSameHour = false
        }
        
        let index = sender.tag
        let storeHourType = storeHourTypeArr[index]
        
        switch(storeHourType){
        case .normal, .allDay:
            storeHourTypeArr[index] = .hoilday
            hoilday.insert(SysUtils.dayOfIndex(index: index))
        case .hoilday:
            storeHourTypeArr[index] = .normal
            if let indexToRemove = hoilday.firstIndex(of: SysUtils.dayOfIndex(index: index)) {
                hoilday.remove(at: indexToRemove)
            }
        }
        
        checkValue()
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
        tableView.endUpdates()
    }
    
    // 24시간 버튼
    @objc func allDayBtnclicked(_ sender: UIButton){
        let index = sender.tag
        let storeHourType = storeHourTypeArr[index]
        
        switch(storeHourType){
        case .normal, .hoilday:
            storeHourTypeArr[index] = .allDay
            if let indexToRemove = hoilday.firstIndex(of: SysUtils.dayOfIndex(index: index)) {
                hoilday.remove(at: indexToRemove)
            }
        case .allDay:
            storeHourTypeArr[index] = .normal
        }
        
        checkValue()
        
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
    }
    
    @objc func setOpenHour(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whenHour = .startTime
            vc.whatHour = .storeHour
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)

        }
    }
    @objc func setCloseHour(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen

            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whenHour = .endTime
            vc.whatHour = .storeHour
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    func checkValue(){
        // 모든 요일 다 입력했는지 검사
        for (index, value) in workHourArr.enumerated(){
            if (storeHourTypeArr[index] == .normal) && ((value.startTime == nil) || (value.endTime == nil)){
                nextBtn.isEnabled = false
                nextBtn.setTitleColor(UIColor(hex: 0xADADAD), for: .normal)
                return
            }
        }
        nextBtn.isEnabled = true
        nextBtn.setTitleColor(UIColor(hex: 0xFFB100), for: .normal)
    }
}

// 테이블뷰 extension
extension RegisterStoreHourVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return workHourArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ // 1. 매장 휴무일
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AllHourSameCell") as? AllHourSameCell {
                cell.setUp(isAllSameHour: self.isAllSameHour, whatHour: .storeHour)
                cell.checkBtn.addTarget(self, action: #selector(allSameBtnclicked(_:)), for: .touchUpInside)
                return cell
            }
        }else if indexPath.section == 1{ // 2. 추가된 영업 시간
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreHourTableViewCell") as? StoreHourTableViewCell {
                cell.selectionStyle = .none
                
                // 오픈 시간
                cell.openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
                cell.openBtn.tag = indexPath.row
                
                // 마감 시간
                cell.closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
                cell.closeBtn.tag = indexPath.row
                
                // 휴무일 버튼
                cell.holidayBtn.tag = indexPath.row
                cell.holidayBtn.addTarget(self, action: #selector(holidayBtnclicked(_:)), for: .touchUpInside)
                
                // 24시간 버튼
                cell.allDayBtn.tag = indexPath.row
                cell.allDayBtn.addTarget(self, action: #selector(allDayBtnclicked(_:)), for: .touchUpInside)
                
                // data setting
                cell.setUp(workHour: self.workHourArr[indexPath.row], storeHourType: self.storeHourTypeArr[indexPath.row])
                cell.dayLabel.text = SysUtils.dayOfIndex(index: indexPath.row) + "요일"
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 74
        }else if indexPath.section == 1{
            return 177
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let middleView = UIView().then {
               $0.backgroundColor = UIColor(hex: 0xefefef)
            }
            return middleView
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 10
        }else{
            return 0.1
        }
    }
}

// 오픈, 마감 시간 delegate
extension RegisterStoreHourVC: TimeDateModalDelegate {
    
    func timeModalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }

    func openTimeTextFieldData(data: String, index: Int) {
        if isAllSameHour{
            isAllSameHour = false
        }
        
        workHourArr[index].startTime = data
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        tableView.endUpdates()
    }
    func endTimeTextFieldData(data: String, index: Int) {
        if isAllSameHour{
            isAllSameHour = false
        }
        
        workHourArr[index].endTime = data
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        tableView.endUpdates()
    }
}

// 모든 요일 동일 delegate
extension RegisterStoreHourVC: AllStoreHourDelegate {
    func getAllTimeHour(workHour: WorkHour, isAllHour: Bool) {
        modalBgView.isHidden = true
        // 영업시간 세팅
        workHourArr = workHourArr.map { _ in
            return workHour
        }
        // 공휴일 모두 제거
        hoilday.removeAll()
        
        storeHourTypeArr = storeHourTypeArr.map { _ in
            if isAllHour{
                return .allDay //24시간 영업
            }else{
                return .normal //default
            }
        }
        
        isAllSameHour = true
        checkValue()
    }
    
    func storeHourModalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }
}
// 영업 시간 설정 미완료 alert delegate
extension RegisterStoreHourVC: StoreHourUnCompletedDelegate {
    func modalDismiss() {
        modalBgView.isHidden = true
    }
    
    func backToPage() {
        self.navigationController?.popViewController(animated: true)
    }
}
