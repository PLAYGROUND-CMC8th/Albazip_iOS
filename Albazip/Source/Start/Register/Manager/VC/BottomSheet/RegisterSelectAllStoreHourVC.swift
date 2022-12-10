//
//  RegisterSelectAllStoreHourVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/08/22.
//

import Foundation
import UIKit
import SnapKit
protocol AllStoreHourDelegate: AnyObject {
    func getAllTimeHour(workHour: WorkHour, isAllHour: Bool)
    func storeHourModalDismiss()
}
class RegisterSelectAllStoreHourVC: UIViewController{
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var cornerView: UIView!
    @IBOutlet var cornerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var allDayBtn: UIButton!
    @IBOutlet var allDayBtnHeightConst: NSLayoutConstraint!
    @IBOutlet var allDayLabel: UILabel!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    let storeHourView = StoreHourView()
    var workHour: WorkHour = WorkHour(startTime: nil, endTime: nil, day: "")
    weak var delegate: AllStoreHourDelegate?
    var whatHour: WhatHour = .storeHour
    
    override func viewDidLoad() {
        setUI()
    }
    
    func setUI(){
        modalBgView.isHidden = true
        
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
        
        self.view.addSubview(storeHourView)
        storeHourView.snp.makeConstraints {
            $0.top.equalTo(allDayBtn.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(68)
        }
        
        allDayBtn.setImage(UIImage(named: "checkCircleInactive24Px"), for: .normal)
        allDayBtn.setImage(UIImage(named: "checkCircleActive24Px"), for: .selected)
        allDayBtn.isSelected = false
        
        storeHourView.openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
        storeHourView.closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
        storeHourView.whatHour = self.whatHour
        
        okBtn.isEnabled = false
        
        if whatHour == .storeHour{ // 영업 시간
            titleLabel.text = "모든 영업시간을 입력해주세요."
            subLabel.text = "기존에 입력했던 영업시간은 모두 사라져요."
            cornerViewHeightConst.constant = 326
            allDayBtnHeightConst.constant = 24
        }else{ // 근무 시간
            titleLabel.text = "근무시간을 입력해주세요."
            subLabel.text = "기존에 입력했던 근무시간은 모두 사라져요."
            allDayBtn.isHidden = true
            allDayLabel.isHidden = true
            cornerViewHeightConst.constant = 288
            allDayBtnHeightConst.constant = 0
        }
    }
    
    @objc func setOpenHour(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.timeDateModalDelegate = self
            vc.whenHour = .startTime
            vc.whatHour = self.whatHour
            vc.index = 7
            vc.workHour = workHour
            self.present(vc, animated: true, completion: nil)

        }
    }
    @objc func setCloseHour(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.timeDateModalDelegate = self
            vc.whenHour = .endTime
            vc.whatHour = self.whatHour
            vc.index = 7
            vc.workHour = workHour
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    @IBAction func allDayBtnClicked(_ sender: Any) {
        if !allDayBtn.isSelected{
            workHour.startTime = nil
            workHour.endTime = nil
        }
        allDayBtn.isSelected.toggle()
        storeHourView.setUp(selected: allDayBtn.isSelected, workHour: workHour)
        checkValue()
    }
    
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        delegate?.storeHourModalDismiss()
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func okBtnClicked(_ sender: Any) {
        delegate?.getAllTimeHour(workHour: self.workHour, isAllHour: allDayBtn.isSelected)
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkValue(){
        if (workHour.startTime != nil && workHour.endTime != nil) || allDayBtn.isSelected{
            okBtn.isEnabled = true
            okBtn.backgroundColor = UIColor(hex: 0xffd85c)
            okBtn.setTitleColor(UIColor(hex: 0x343434), for: .normal)
        }else{
            okBtn.isEnabled = false
            okBtn.backgroundColor = UIColor(hex: 0xffefbd)
            okBtn.setTitleColor(UIColor(hex: 0xadadad), for: .normal)
        }
    }
}
// 오픈, 마감 시간 delegate
extension RegisterSelectAllStoreHourVC: TimeDateModalDelegate {
    
    func timeModalDismiss() {
        modalBgView.isHidden = true
    }

    func openTimeTextFieldData(data: String, index: Int) {
        workHour.startTime = data
        storeHourView.setUp(selected: false, workHour: workHour)
        checkValue()
    }
    func endTimeTextFieldData(data: String, index: Int) {
        workHour.endTime = data
        storeHourView.setUp(selected: false, workHour: workHour)
        checkValue()
    }
}
