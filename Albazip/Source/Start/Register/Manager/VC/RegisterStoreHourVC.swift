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
    // enable:0, selected:1, disabled: 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setUI(){
    }
    @IBAction func btnNext(_ sender: Any) {

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
            return 1
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
                
                let totalHouur = UILabel().then {
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
                cell.contentView.addSubview(totalHouur)
                
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
                
                totalHouur.snp.makeConstraints {
                    $0.top.equalTo(closeBtn.snp.bottom).offset(8)
                    $0.trailing.equalToSuperview().inset(24)
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
                
//                hourBtn.addTarget(self, action: #selector(goStoreHourPage(_:)), for: .touchUpInside)
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
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
