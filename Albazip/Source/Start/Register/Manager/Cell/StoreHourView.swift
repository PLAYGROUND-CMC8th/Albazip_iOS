//
//  StoreHourView.swift
//  Albazip
//
//  Created by 김수빈 on 2022/08/22.
//

import SnapKit
import UIKit

// 오픈시간, 마감시간 선택뷰
class StoreHourView: UIView {
    let openStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 0
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins.left = 16.0
    }
    
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
    
    let closeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 0
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins.left = 16.0
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLayout() {
        self.addSubview(openStackView)
        self.addSubview(closeStackView)
        self.addSubview(waveImg)
        
        self.addSubview(openBtn)
        self.addSubview(closeBtn)
        self.addSubview(totalHour)
        
        waveImg.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(15)
            $0.top.equalToSuperview().offset(14)
            $0.centerX.equalToSuperview()
        }
        
        openBtn.snp.makeConstraints {
            $0.trailing.equalTo(waveImg.snp.leading).offset(-20)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(45)
            $0.centerY.equalTo(waveImg.snp.centerY)
        }
        
        closeBtn.snp.makeConstraints {
            $0.leading.equalTo(waveImg.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(45)
            $0.centerY.equalTo(waveImg.snp.centerY)
        }
        
        totalHour.snp.makeConstraints {
            $0.top.equalTo(closeBtn.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        openStackView.snp.makeConstraints {
            $0.top.equalTo(openBtn.snp.top)
            $0.bottom.equalTo(openBtn.snp.bottom)
            $0.leading.equalTo(openBtn.snp.leading)
            $0.trailing.equalTo(openBtn.snp.trailing)
        }
        openStackView.addArrangedSubview(openLabel)
        openStackView.addArrangedSubview(openTimeLabel)
        
        openLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.centerY.equalToSuperview()
        }
        
        openTimeLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.centerY.equalToSuperview()
        }
        
        closeStackView.snp.makeConstraints {
            $0.top.equalTo(closeBtn.snp.top)
            $0.bottom.equalTo(closeBtn.snp.bottom)
            $0.leading.equalTo(closeBtn.snp.leading)
            $0.trailing.equalTo(closeBtn.snp.trailing)
        }
        
        closeStackView.addArrangedSubview(closeLabel)
        closeStackView.addArrangedSubview(closeTimeLabel)
        
        closeTimeLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.centerY.equalToSuperview()
        }
        
        closeLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setUp(selected: Bool, workHour: WorkHour){
        if selected{
            // 오픈 시간
            openTimeLabel.text = "00:00"
            openTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            openBtn.backgroundColor = UIColor(hex: 0xf5f5f5)
            openBtn.isEnabled = false
            self.sendSubviewToBack(openBtn)
            openLabel.textColor = UIColor(hex: 0xcecece)
            
            // 마감 시간
            closeTimeLabel.text = "00:00"
            closeTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            closeBtn.backgroundColor = UIColor(hex: 0xf5f5f5)
            closeBtn.isEnabled = false
            self.sendSubviewToBack(closeBtn)
            closeLabel.textColor = UIColor(hex: 0xcecece)
            
            totalHour.text = "24시간"
        }else{
            // 오픈 시간
            openBtn.layer.borderColor = UIColor(hex: 0xededed).cgColor
            openBtn.backgroundColor = .clear
            openBtn.isEnabled = true
            self.bringSubviewToFront(openBtn)
            openLabel.textColor = UIColor(hex: 0xa3a3a3)
            
            if let startTime = workHour.startTime{
                openTimeLabel.text = startTime
                openTimeLabel.textColor = UIColor(hex: 0x343434)
            }else{
                openTimeLabel.text = "00:00"
                openTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            }
            
            // 마감 시간
            closeBtn.layer.borderColor = UIColor(hex: 0xededed).cgColor
            closeBtn.backgroundColor = .clear
            closeBtn.isEnabled = true
            self.bringSubviewToFront(closeBtn)
            closeLabel.textColor = UIColor(hex: 0xa3a3a3)
            
            if let endTime = workHour.endTime{
                closeTimeLabel.text = endTime
                closeTimeLabel.textColor = UIColor(hex: 0x343434)
            }else{
                closeTimeLabel.text = "00:00"
                closeTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            }
            
            // 시간차 구하기
            calculateTime(workHour: workHour)
        }
    }
    
    // 시간차 구하기
    func calculateTime(workHour: WorkHour){
        guard let openHour = workHour.startTime, let closeHour = workHour.endTime else {
            totalHour.text = "0시간"
            return
        }
        
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

        totalHour.text = "\(hour)시간\(minute)분"
    }
}
