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

class RegisterStoreHourVC: UIViewController, StoreClosedDayDelegate{
    
    @IBOutlet var tableView: UITableView!
    // 버튼 선택 정보 저장
    var btnArray = [0, 0, 0, 0, 0, 0, 0, 0]
    // 순서) 연중 무휴, 월-금, 휴무일
    // enable:0, selected:1, disabled: 2, added:3
    var workHourArr = [WorkHour]()
    var openHour = "" // 오픈 시간
    var closeHour = "" // 마감 시간
    var diffHour = "" // 오픈시간 - 마감시간 차이
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let registerManagerInfo = RegisterManagerInfo.shared
        if let workHour = registerManagerInfo.workHour, let btnArr = registerManagerInfo.btnArr{
            workHourArr = workHour
            btnArray = btnArr
            tableView.reloadData()
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setUI(){
    }
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.workHour = workHourArr
        registerManagerInfo.btnArr = btnArray
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StoreHourTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "StoreHourTableViewCell")
    }
    
    func btnDayClicked(index: Int) {
        switch (index){
        case 0:
            if !btnArray.contains(3){
                if btnArray[index] == 0{
                    btnArray[index] = 1
                    for i in 1...7{
                        btnArray[i] = 2
                    }
                }else if btnArray[index] == 1{
                    btnArray[index] = 0
                    for i in 1...7{
                        btnArray[i] = 0
                    }
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
    
    @objc func addStoreHour(_ sender: UIButton){
        for (i, value) in btnArray.enumerated(){
            if i != 0, value == 1{
                btnArray[i] = 3 // 선택된 버튼 비활성화
                workHourArr.append(WorkHour(startTime: openHour, endTime: closeHour, day: dayOfIndex(index: i), number: i))
            }else if i == 0, value == 1{
                btnArray[i] = 3
                for i in 1...7{
                    btnArray[i] = 3
                    workHourArr.append(WorkHour(startTime: openHour, endTime: closeHour, day: dayOfIndex(index: i), number: i))
                }
            }
        }
        // 월 - 금 순으로 정렬
        workHourArr = workHourArr.sorted(by: {$0.number < $1.number})
        // 값 초기화
        openHour = ""
        closeHour = ""
        
        tableView.reloadData()
    }
    
    func dayOfIndex(index :Int) -> String{
        switch (index){
            case 1: return "월"
            case 2 : return "화"
            case 3 : return "수"
            case 4: return "목"
            case 5 : return "금"
            case 6 : return "토"
            case 7: return "일"
            default: return ""
        }
    }
    
    @objc func deleteStoreHour(_ sender: UIButton){
        for i in 1...7{
            if (dayOfIndex(index: i) == workHourArr[sender.tag].day){
                btnArray[i] = 0
                break
            }
        }
        workHourArr.remove(at: sender.tag)
        tableView.reloadData()
    }
}
// 테이블뷰 extension
extension RegisterStoreHourVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 51
        }else{
            return 61
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView().then{
            $0.backgroundColor = .white
        }
        let sectionTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            $0.textColor = UIColor(hex: 0x6f6f6f)
        }
        
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(19)
        }
        
        if section == 0{
            sectionTitle.text = "영업시간"
        }else {
            sectionTitle.text = "추가된 영업시간"
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else{
            return workHourArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ // 1. 매장 휴무일
            if indexPath.row == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreHourTableViewCell") as? StoreHourTableViewCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.setUp(btnArray: self.btnArray)
                    return cell
                }
            }else if indexPath.row == 1{
                let cell = UITableViewCell()
                let openBtn = UIButton().then{
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                    $0.layer.borderWidth = 1
                    $0.layer.cornerRadius = 10
                }
                let openLabel = UILabel().then{
                    $0.textColor = UIColor(hex: 0x6f6f6f)
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    $0.text = "오픈시간"
                }
                let openTimeLabel = UILabel().then{
                    $0.textColor = UIColor(hex: 0xededed)
                    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                    $0.text = "00:00"
                }
                let closeBtn = UIButton().then{
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                    $0.layer.borderWidth = 1
                    $0.layer.cornerRadius = 10
                }
                let closeLabel = UILabel().then{
                    $0.textColor = UIColor(hex: 0x6f6f6f)
                    $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    $0.text = "마감시간"
                }
                let closeTimeLabel = UILabel().then{
                    $0.textColor = UIColor(hex: 0xededed)
                    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                    $0.text = "00:00"
                }
                let waveImg = UIImageView().then{
                    $0.image = UIImage(named: "wave")
                }
                
                let totalHour = UILabel().then {
                    $0.textColor = UIColor(hex: 0xa3a3a3)
                    $0.text = "0시간"
                    $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                }
                cell.contentView.addSubview(openLabel)
                cell.contentView.addSubview(openTimeLabel)
                cell.contentView.addSubview(closeLabel)
                cell.contentView.addSubview(closeTimeLabel)
                cell.contentView.addSubview(waveImg)
                
                cell.contentView.addSubview(openBtn)
                cell.contentView.addSubview(closeBtn)
                cell.contentView.addSubview(totalHour)
                
                openLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(30)
                    $0.leading.equalToSuperview().inset(40)
                }
                
                openTimeLabel.snp.makeConstraints {
                    $0.centerY.equalTo(openLabel.snp.centerY)
                    $0.leading.equalTo(openLabel.snp.trailing).offset(11)
                }
                
                closeTimeLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(30)
                    $0.trailing.equalToSuperview().inset(40)
                }
                
                closeLabel.snp.makeConstraints {
                    $0.centerY.equalTo(closeTimeLabel.snp.centerY)
                    $0.trailing.equalTo(closeTimeLabel.snp.leading).offset(-11)
                }
                
                waveImg.snp.makeConstraints {
                    $0.width.equalTo(20)
                    $0.height.equalTo(15)
                    $0.top.equalToSuperview().inset(30)
                    $0.centerX.equalToSuperview()
                }
                
                openBtn.snp.makeConstraints {
                    $0.trailing.equalTo(waveImg.snp.leading).offset(-20)
                    $0.leading.equalToSuperview().inset(24)
                    $0.height.equalTo(45)
                    $0.top.equalToSuperview().inset(16)
                }
                
                closeBtn.snp.makeConstraints {
                    $0.leading.equalTo(waveImg.snp.trailing).offset(20)
                    $0.trailing.equalToSuperview().inset(24)
                    $0.height.equalTo(45)
                    $0.top.equalToSuperview().inset(16)
                }
                
                totalHour.snp.makeConstraints {
                    $0.top.equalTo(closeBtn.snp.bottom).offset(8)
                    $0.trailing.equalToSuperview().inset(24)
                }
                
                openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
                
                closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
                
                if openHour != ""{
                    openTimeLabel.text = openHour
                    openTimeLabel.textColor = UIColor(hex: 0x343434)
                }
                
                if closeHour != ""{
                    closeTimeLabel.text = closeHour
                    closeTimeLabel.textColor = UIColor(hex: 0x343434)
                }
                
                if diffHour != ""{
                    totalHour.text = diffHour
                }
                
                return cell
            }else if indexPath.row == 2{
                let cell = UITableViewCell()
                let hourBtn = UIButton().then{
                    $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    $0.setTitle("시간 추가", for: .normal)
                    $0.layer.cornerRadius = 10
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                }
                cell.contentView.addSubview(hourBtn)
                hourBtn.snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.trailing.leading.equalToSuperview().inset(24)
                    $0.height.equalTo(39)
                }
                if btnArray.contains(1), openHour != "", closeHour != ""{
                    hourBtn.addTarget(self, action: #selector(addStoreHour(_:)), for: .touchUpInside)
                }else{
                    hourBtn.setTitleColor(UIColor(hex: 0xededed), for: .normal)
                }
                
                return cell
            }
        }else if indexPath.section == 1{ // 2. 추가된 영업 시간
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
            let deleteBtn = UIButton().then{
                $0.setImage(UIImage(named: "icDelete24Px"), for: .normal)
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
                $0.height.equalTo(49)
                $0.top.bottom.trailing.leading.equalToSuperview()
            }
            cell.addSubview(dayTotalView)
            dayTotalView.snp.makeConstraints {
                $0.trailing.leading.equalToSuperview().inset(24)
                $0.bottom.top.equalToSuperview().inset(6)
            }
            cell.contentView.addSubview(deleteBtn)
            deleteBtn.snp.makeConstraints {
                $0.height.width.equalTo(20)
                $0.trailing.equalToSuperview().inset(40)
                $0.centerY.equalToSuperview()
            }
            
            //Data Setting
            let day = workHourArr[indexPath.row]
            dayTime.text = "\(day.startTime) ~ \(day.endTime)"
            dayTitle.text = day.day
            
            deleteBtn.tag = indexPath.row
            deleteBtn.addTarget(self, action: #selector(deleteStoreHour(_:)), for: .touchUpInside)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                return 124
            }else if indexPath.row == 1{
                return 96
            }else{
                return 39 + 24
            }
        }else if indexPath.section == 1{
            return 61
        }else{
            return 45
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let middleView = UIView().then {
            if section == 0{
                $0.backgroundColor = UIColor(hex: 0xefefef)
            }else{
                $0.backgroundColor = .white
            }
        }
        return middleView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 10
        }else{
            return 0
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
    var number: Int
}
