//
//  StoreHourTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/05/30.
//

import UIKit

// 매장 영업시간 타입
enum StoreHourType: Int{
    case normal // default
    case hoilday // 휴무일
    case allDay // 24시간 영업
}

class StoreHourTableViewCell: UITableViewCell {

    let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = "월요일"
    }
    
    let holidayImage = UIImageView().then {
        $0.image = UIImage(named: "checkCircleInactive24Px")
//        $0.setImage(UIImage(named: "checkCircleActive24Px"), for: .selected)
    }
    
    let holidayBtn = UIButton()

    let holidayLabel = UILabel().then {
        $0.text = "휴무일"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = UIColor(hex: 0x343434)
    }

    let allDayImage = UIImageView().then {
        $0.image = UIImage(named: "checkCircleInactive24Px")
//        $0.setImage(UIImage(named: "checkCircleActive24Px"), for: .selected)
    }
    
    let allDayBtn = UIButton()
    
    let allDayLabel = UILabel().then {
        $0.text = "24시간 영업"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = UIColor(hex: 0x343434)
    }
    
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
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xededed)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureUI(){
        // 1. 요일 이름
        configureDayView()
        
        // 2. 휴무일, 24시간 영업
        configureCheckView()
        
        // 3. 오픈시간, 마감시간
        configureHourView()
    }
    
    // 1. 요일 이름
    func configureDayView(){
        self.contentView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
            $0.height.equalTo(19)
        }
    }
    
    // 2. 휴무일, 24시간 영업
    func configureCheckView(){
        self.contentView.addSubview(holidayImage)
        self.contentView.addSubview(holidayLabel)
        self.contentView.addSubview(holidayBtn)
        self.contentView.addSubview(allDayImage)
        self.contentView.addSubview(allDayLabel)
        self.contentView.addSubview(allDayBtn)
        
        holidayImage.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
        
        holidayLabel.snp.makeConstraints {
            $0.centerY.equalTo(holidayImage.snp.centerY)
            $0.leading.equalTo(holidayImage.snp.trailing).offset(4)
        }
        
        holidayBtn.snp.makeConstraints {
            $0.leading.equalTo(holidayImage.snp.leading)
            $0.top.equalTo(holidayImage.snp.top)
            $0.trailing.equalTo(holidayLabel.snp.trailing)
            $0.height.equalTo(24)
        }
        
        allDayImage.snp.makeConstraints {
            $0.centerY.equalTo(holidayImage.snp.centerY)
            $0.leading.equalTo(holidayLabel.snp.trailing).offset(12)
            $0.width.height.equalTo(24)
        }
        
        allDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(holidayImage.snp.centerY)
            $0.leading.equalTo(allDayImage.snp.trailing).offset(4)
        }
        
        allDayBtn.snp.makeConstraints {
            $0.leading.equalTo(allDayImage.snp.leading)
            $0.top.equalTo(allDayImage.snp.top)
            $0.trailing.equalTo(allDayLabel.snp.trailing)
            $0.height.equalTo(24)
        }
    }
    
    // 3. 오픈시간, 마감시간
    func configureHourView(){
        self.contentView.addSubview(openStackView)
        self.contentView.addSubview(closeStackView)
        self.contentView.addSubview(waveImg)
        
        self.contentView.addSubview(openBtn)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(totalHour)
        
        self.contentView.addSubview(lineView)
        
        waveImg.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(15)
            $0.top.equalTo(holidayImage.snp.bottom).offset(28)
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
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setUp(workHour: WorkHour, storeHourType: StoreHourType){
        
        if storeHourType == .normal{
            holidayBtn.isSelected = false
            holidayImage.image = UIImage(named: "checkCircleInactive24Px")
            allDayBtn.isSelected = false
            allDayImage.image = UIImage(named: "checkCircleInactive24Px")
            
            // 오픈 시간
            openBtn.layer.borderColor = UIColor(hex: 0xededed).cgColor
            openBtn.backgroundColor = .clear
            openBtn.isEnabled = true
            self.contentView.bringSubviewToFront(openBtn)
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
            self.contentView.bringSubviewToFront(closeBtn)
            closeLabel.textColor = UIColor(hex: 0xa3a3a3)
            
            if let endTime = workHour.endTime{
                closeTimeLabel.text = endTime
                closeTimeLabel.textColor = UIColor(hex: 0x343434)
            }else{
                closeTimeLabel.text = "00:00"
                closeTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            }
            
            // 시간차 구하기
            totalHour.text = SysUtils.calculateTime(workHour: workHour)
        }else{
            // 오픈 시간
            openTimeLabel.text = "00:00"
            openTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            openBtn.backgroundColor = UIColor(hex: 0xf5f5f5)
            openBtn.isEnabled = false
            self.contentView.sendSubviewToBack(openBtn)
            openLabel.textColor = UIColor(hex: 0xcecece)
            
            // 마감 시간
            closeTimeLabel.text = "00:00"
            closeTimeLabel.textColor = UIColor(hex: 0xe2e2e2)
            closeBtn.backgroundColor = UIColor(hex: 0xf5f5f5)
            closeBtn.isEnabled = false
            self.contentView.sendSubviewToBack(closeBtn)
            closeLabel.textColor = UIColor(hex: 0xcecece)
            
            // 휴무일
            if storeHourType == .hoilday {
                holidayBtn.isSelected = true
                holidayImage.image = UIImage(named: "checkCircleActive24Px")
                allDayBtn.isSelected = false
                allDayImage.image = UIImage(named: "checkCircleInactive24Px")
                totalHour.text = "0시간"
            }else{ // 24시간 영업
                holidayBtn.isSelected = false
                holidayImage.image = UIImage(named: "checkCircleInactive24Px")
                allDayBtn.isSelected = true
                allDayImage.image = UIImage(named: "checkCircleActive24Px")
                totalHour.text = "24시간"
            }
        }
    }
}
