//
//  WorkHourTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/04.
//

import Foundation
class WorkHourTableViewCell: UITableViewCell {
    let checkBtn = UIButton().then{
        $0.setImage(UIImage(named: "checkCircleInactive30Px"), for: .normal)
    }
    
    let checkLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = "모든 근무시간이 같아요."
    }
    
    let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = "월요일"
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xededed)
    }
    
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
        [checkBtn, dayLabel].forEach {
            self.contentView.addSubview($0)
        }
      
        checkBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.width.height.equalTo(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        dayLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBtn.snp.centerY)
            $0.leading.equalTo(checkBtn.snp.trailing).offset(6)
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
        self.dayLabel.text = SysUtils.dayOfIndex(index: index)
        storeHourView.setUp(selected: false, workHour: workHour)
        if workDayType{
            storeHourView.isHidden = false
            checkBtn.setImage(UIImage(named: "checkCircleActive30Px"), for: .normal)
        }else{
            storeHourView.isHidden = true
            checkBtn.setImage(UIImage(named: "checkCircleInactive30Px"), for: .normal)
        }
    }
}
