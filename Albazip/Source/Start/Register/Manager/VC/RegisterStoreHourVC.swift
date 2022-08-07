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
    
    @IBOutlet var tableView: UITableView!
    // 버튼 선택 정보 저장
//    var btnArray = [0, 0, 0, 0, 0, 0, 0, 0]
    // 순서) 연중 무휴, 월-금, 휴무일
    // enable:0, selected:1, disabled: 2, added:3
    var workHourArr = [WorkHour]()
    var openHour = "" // 오픈 시간
    var closeHour = "" // 마감 시간
    var diffHour = "" // 오픈시간 - 마감시간 차이
    var isAllSameHour = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func initWorkHour(){
        for i in 0...6{
            workHourArr.append(WorkHour(startTime: "00:00", endTime: "00:00", day: dayOfIndex(index: i), holiday: false))
        }
    }
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.workHour = workHourArr
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StoreHourTableViewCell.self, forCellReuseIdentifier: "StoreHourTableViewCell")
    }
   
    @objc func allSameBtnclicked(_ sender: UIButton){
        isAllSameHour = !isAllSameHour
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    @objc func holidayBtnclicked(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    
    @objc func allDayBtnclicked(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    
    @objc func setOpenHour(_ sender: UIButton) {

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen

//                modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 0
            vc.titletext = "매장 오픈 시간"
            self.present(vc, animated: true, completion: nil)

        }
    }
    @objc func setCloseHour(_ sender: UIButton) {

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen

//                modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 1
            vc.titletext = "매장 마감 시간"
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    //시간차 구하기
    func calculateTime(){
        if openHour.count > 0, closeHour.count > 0{
            let startTime = openHour.components(separatedBy: ":")
            let endTime = closeHour.components(separatedBy: ":")
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

            diffHour = "\(hour)시간\(minute)분"
        }
    }
    
//    @objc func addStoreHour(_ sender: UIButton){
//        for (i, value) in btnArray.enumerated(){
//            if i != 0, value == 1{
//                btnArray[i] = 3 // 선택된 버튼 비활성화
//                workHourArr.append(WorkHour(startTime: openHour, endTime: closeHour, day: dayOfIndex(index: i), number: i))
//            }else if i == 0, value == 1{
//                btnArray[i] = 3
//                for i in 1...7{
//                    btnArray[i] = 3
//                    workHourArr.append(WorkHour(startTime: openHour, endTime: closeHour, day: dayOfIndex(index: i), number: i))
//                }
//            }
//        }
//        // 월 - 금 순으로 정렬
//        workHourArr = workHourArr.sorted(by: {$0.number < $1.number})
//        // 값 초기화
//        openHour = ""
//        closeHour = ""
//
//        tableView.reloadData()
//    }
    
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
    
//    @objc func deleteStoreHour(_ sender: UIButton){
//        for i in 1...7{
//            if (dayOfIndex(index: i) == workHourArr[sender.tag].day){
//                btnArray[i] = 0
//                break
//            }
//        }
//        workHourArr.remove(at: sender.tag)
//        tableView.reloadData()
//    }
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
//
//                openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
//
//                closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
//
//                if openHour != ""{
//                    openTimeLabel.text = openHour
//                    openTimeLabel.textColor = UIColor(hex: 0x343434)
//                }
//
//                if closeHour != ""{
//                    closeTimeLabel.text = closeHour
//                    closeTimeLabel.textColor = UIColor(hex: 0x343434)
//                }
//
//                if diffHour != ""{
//                    totalHour.text = diffHour
//                }
//
//                return cell
        }else if indexPath.section == 1{ // 2. 추가된 영업 시간
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreHourTableViewCell") as? StoreHourTableViewCell {
                cell.selectionStyle = .none
//                    cell.setUp(btnArray: self.btnArray)
                
                cell.openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
        
                cell.closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
                
                if openHour != ""{
                    cell.openTimeLabel.text = openHour
                    cell.openTimeLabel.textColor = UIColor(hex: 0x343434)
                }
        
                if closeHour != ""{
                    cell.closeTimeLabel.text = closeHour
                    cell.closeTimeLabel.textColor = UIColor(hex: 0x343434)
                }
        
                if diffHour != ""{
                    cell.totalHour.text = diffHour
                }
                
                cell.holidayBtn.tag = indexPath.row
                cell.holidayBtn.addTarget(self, action: #selector(holidayBtnclicked(_:)), for: .touchUpInside)
                
                cell.allDayBtn.tag = indexPath.row
                cell.allDayBtn.addTarget(self, action: #selector(allDayBtnclicked(_:)), for: .touchUpInside)
                return cell
            }

//
//            //Data Setting
//            let day = workHourArr[indexPath.row]
//            dayTime.text = "\(day.startTime) ~ \(day.endTime)"
//            dayTitle.text = day.day
//
//            deleteBtn.tag = indexPath.row
////            deleteBtn.addTarget(self, action: #selector(deleteStoreHour(_:)), for: .touchUpInside)
//
//            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
        }
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
//        modalBgView.isHidden = true
//        checkValue()
    }

    func openTimeTextFieldData(data: String) {
        openHour = data
        calculateTime()
        tableView.reloadData()
    }
    func endTimeTextFieldData(data: String) {
        closeHour = data
        calculateTime()
        tableView.reloadData()
    }
}

struct WorkHour: Encodable {
    var startTime: String
    var endTime: String
    var day: String
//    var number: Int
    var holiday: Bool
}
