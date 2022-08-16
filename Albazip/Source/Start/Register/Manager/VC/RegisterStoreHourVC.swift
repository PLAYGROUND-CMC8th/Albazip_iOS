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
        setUI()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let registerManagerInfo = RegisterManagerInfo.shared
        if let workHour = registerManagerInfo.workHour{
            workHourArr = workHour
        }else{
            initWorkHour()
        }
        tableView.reloadData()
    }
    
    func setUI(){
        modalBgView.isHidden = true
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StoreHourTableViewCell.self, forCellReuseIdentifier: "StoreHourTableViewCell")
    }
    
    func initWorkHour(){
        for i in 0...6{
            workHourArr.append(WorkHour(startTime: nil, endTime: nil, day: dayOfIndex(index: i)))
            storeHourTypeArr.append(.normal)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.workHour = workHourArr
        self.navigationController?.popViewController(animated: true)
    }
   
    // 모든 요일 동일 버튼
    @objc func allSameBtnclicked(_ sender: UIButton){
        isAllSameHour = !isAllSameHour
    }
    
    // 휴무일 버튼
    @objc func holidayBtnclicked(_ sender: UIButton){
        let index = sender.tag
        let storeHourType = storeHourTypeArr[index]
        
        switch(storeHourType){
        case .normal, .allDay:
            storeHourTypeArr[index] = .hoilday
            workHourArr[index].startTime = nil
            workHourArr[index].endTime = nil
            hoilday.insert(dayOfIndex(index: index))
        case .hoilday:
            storeHourTypeArr[index] = .normal
            if let indexToRemove = hoilday.firstIndex(of: dayOfIndex(index: index)) {
                hoilday.remove(at: indexToRemove)
            }
        }
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
    }
    
    // 24시간 버튼
    @objc func allDayBtnclicked(_ sender: UIButton){
        let index = sender.tag
        let storeHourType = storeHourTypeArr[index]
        
        switch(storeHourType){
        case .normal, .hoilday:
            storeHourTypeArr[index] = .allDay
            workHourArr[index].startTime = nil
            workHourArr[index].endTime = nil
        case .allDay:
            storeHourTypeArr[index] = .normal
        }
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
    }
    
    @objc func setOpenHour(_ sender: UIButton) {

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 0
            vc.titletext = "매장 오픈 시간"
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)

        }
    }
    @objc func setCloseHour(_ sender: UIButton) {

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen

            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 1
            vc.titletext = "매장 마감 시간"
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    func dayOfIndex(index :Int) -> String{
        switch (index){
            case 0: return "월"
            case 1 : return "화"
            case 2 : return "수"
            case 3: return "목"
            case 4 : return "금"
            case 5 : return "토"
            case 6: return "일"
            default: return ""
        }
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
            let cell = UITableViewCell()
            
            let checkBtn = UIButton().then{
                if isAllSameHour{
                    $0.setImage(UIImage(named: "checkCircleActive30Px"), for: .normal)
                }else{
                    $0.setImage(UIImage(named: "checkCircleInactive30Px"), for: .normal)
                }
            }
            
            let checkLabel = UILabel().then{
                $0.font = .systemFont(ofSize: 16, weight: .medium)
                $0.textColor = UIColor(hex: 0x343434)
                $0.text = "모든 영업시간이 같아요."
            }
            
            cell.contentView.addSubview(checkBtn)
            cell.contentView.addSubview(checkLabel)
            
            checkBtn.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(30)
                $0.leading.equalToSuperview().inset(24)
            }
            
            checkLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(checkBtn.snp.trailing).offset(6)
            }
            
            checkBtn.addTarget(self, action: #selector(allSameBtnclicked(_:)), for: .touchUpInside)
            return cell
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
                cell.dayLabel.text = dayOfIndex(index: indexPath.row)
                
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
//        checkValue()
    }

    func openTimeTextFieldData(data: String, index: Int) {
        workHourArr[index].startTime = data
        
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
    }
    func endTimeTextFieldData(data: String, index: Int) {
        workHourArr[index].endTime = data
        
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
    }
}
