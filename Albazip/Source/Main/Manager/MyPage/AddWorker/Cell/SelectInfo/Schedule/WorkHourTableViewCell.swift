//
//  WorkHourTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/04.
//

import Foundation
class WorkHourTableViewCell: UITableViewCell {
    let checkImage = UIImageView().then{
        $0.image = UIImage(named: "checkCircleInactive30Px")
    }
    
    let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = "월요일"
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xededed)
    }
    
    let checkBtn = UIButton()
    
    let storeHourView = StoreHourView()
    var isAllSameHour : Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI(){
        self.selectionStyle = .none
        
        // 1. 요일 이름
        configureDayView()
        
        // 2. 오픈시간, 마감시간
        configureHourView()
    }
    
    // 1. 요일 이름
    func configureDayView(){
        [checkImage, dayLabel, checkBtn].forEach {
            self.contentView.addSubview($0)
        }
      
        checkImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.width.height.equalTo(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        dayLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkImage.snp.centerY)
            $0.leading.equalTo(checkImage.snp.trailing).offset(6)
        }
        
        checkBtn.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
    }
    
    // 2. 오픈시간, 마감시간
    func configureHourView(){
        [storeHourView, lineView].forEach {
            self.contentView.addSubview($0)
        }
        
        storeHourView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(17.5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(68)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        storeHourView.isHidden = true
    }
    
    // 셀 데이터 세팅
    func setUp(workHour: WorkHour, workDayType:Bool, index: Int){
        self.dayLabel.text = SysUtils.dayOfIndex(index: index) + "요일"
        storeHourView.setUp(selected: false, workHour: workHour)
        if workDayType{
            storeHourView.isHidden = false
            checkImage.image = UIImage(named: "checkCircleActive30Px")
        }else{
            storeHourView.isHidden = true
            checkImage.image = UIImage(named: "checkCircleInactive30Px")
        }
    }
}
