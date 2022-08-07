//
//  StoreHourTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/05/30.
//

import UIKit

class StoreHourTableViewCell: UITableViewCell {
    
    let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(hex: 0x343434)
        $0.text = ""
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
//        let Btn = UIButton().then {
//        $0.backgroundColor = "FFFFFF".stringToColor()
//    }
//    
//    let button = UIButton().then {
//        $0.backgroundColor = "FFFFFF".stringToColor()
//    }
//    
//    let lineView = UIView().then {
//        $0.backgroundColor = "DDDDDD".stringToColor()
//    }

    var delegate: StoreClosedDayDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configureUI(){
        self.contentView.addSubview(openLabel)
        self.contentView.addSubview(openTimeLabel)
        self.contentView.addSubview(closeLabel)
        self.contentView.addSubview(closeTimeLabel)
        self.contentView.addSubview(waveImg)
        
        self.contentView.addSubview(openBtn)
        self.contentView.addSubview(closeBtn)
        self.contentView.addSubview(totalHour)
        
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
        
//        openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
//
//        closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
        
//        if openHour != ""{
//            openTimeLabel.text = openHour
//            openTimeLabel.textColor = UIColor(hex: 0x343434)
//        }
//
//        if closeHour != ""{
//            closeTimeLabel.text = closeHour
//            closeTimeLabel.textColor = UIColor(hex: 0x343434)
//        }
//
//        if diffHour != ""{
//            totalHour.text = diffHour
//        }

    }
    
    @objc func btnEveryDay(_ sender: Any){
        delegate?.btnDayClicked(index: 0)
    }

    
    func setUp(btnArray: [Int]){
//        setBtnState(btn: btnEveryDay,state: btnArray[0])
        
    }
    
    func setBtnState(btn: UIButton, state: Int){
        if state == 0{
            btn.backgroundColor = .none
            btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 0.9245131612, green: 0.9296400547, blue: 0.9250692725, alpha: 1)
        }else if state == 1{
            btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 1, green: 0.8398586512, blue: 0.2317804694, alpha: 1)
        }else{
            btn.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }
    }
}
