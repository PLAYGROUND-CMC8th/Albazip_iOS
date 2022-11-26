//
//  AllHourSameCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/11/26.
//

class AllHourSameCell: UITableViewCell {
    
    let checkImage = UIImageView().then{
        $0.image = UIImage(named: "checkCircleInactive30Px")
    }
    
    let checkLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = "모든 영업시간이 같아요."
    }
    
    let checkBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI(){
        [checkImage, checkLabel, checkBtn].forEach {
            self.contentView.addSubview($0)
        }
        
        checkImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        checkLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkImage.snp.trailing).offset(6)
        }
        
        checkBtn.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
    }
    
    // 셀 데이터 세팅
    func setUp(isAllSameHour: Bool, whatHour: WhatHour){
        if isAllSameHour{
            checkImage.image = UIImage(named: "checkCircleActive30Px")
        }else{
            checkImage.image = UIImage(named: "checkCircleInactive30Px")
        }
        
        if whatHour == .storeHour{
            checkLabel.text = "모든 영업시간이 같아요."
        }else{
            checkLabel.text = "모든 근무시간이 같아요."
        }
    }
}
