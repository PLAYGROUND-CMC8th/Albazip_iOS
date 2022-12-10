//
//  RegisterSelectTimeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/30.
//

import Foundation
import UIKit

protocol TimeDateModalDelegate {
    func timeModalDismiss()
    func openTimeTextFieldData(data: String, index: Int)
    func endTimeTextFieldData(data: String, index: Int)
}

enum WhatHour:Int {
    case storeHour // 영업 시간
    case workHour // 근무 시간
}

enum WhenHour:Int{
    case startTime // 오픈, 출근 시간
    case endTime // 마감, 퇴근 시간
}

class RegisterSelectTimeVC: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cornerView: UIView!
    @IBOutlet var cornerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var pickerView2: UIPickerView!
    
    var timeDateModalDelegate : TimeDateModalDelegate?
    var date1 =  [String]()
    var date2 =  [String]()
    var selectedDate1 = 0
    var selectedDate2 = 0

    var whatHour: WhatHour = .storeHour
    var whenHour: WhenHour = .startTime
    var workHour: WorkHour?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in (0..<24) {
            if(i<10){
                date1.append("0\(i)")
            }else{
                date1.append("\(i)")
            }
        }
        for i in (0..<60) {
            if(i<10){
                date2.append("0\(i)")
            }else{
                date2.append("\(i)")
            }
                
            
        }
        setUI()
    }
    
    func setUI() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self

        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
        
        
        switch(whatHour){
        case .storeHour:
            switch(whenHour){
            case .startTime:
                titleLabel.text = "매장 오픈 시간"
            case .endTime:
                titleLabel.text = "매장 마감 시간"
            }
        case .workHour:
            switch(whenHour){
            case .startTime:
                titleLabel.text = "출근 시간"
            case .endTime:
                titleLabel.text = "퇴근 시간"
            }
        }
        
        if whenHour == .startTime || whatHour == .workHour{
            subLabel.isHidden = true
            cornerViewHeightConst.constant = 365
        }else{
            subLabel.isHidden = false
            cornerViewHeightConst.constant = 390
        }
    }
    
   
    @IBAction func btnNext(_ sender: Any) {
        let dateStr = date1[selectedDate1]+":"+date2[selectedDate2]
        if let workHour = workHour {
            if whenHour == .startTime, let endTime = workHour.endTime, dateStr == endTime {
                self.showMessage(message: "퇴근 시간과 같아요. 시간을 다시 설정해주세요.", controller: self, bottomInset: 112)
                return
            }else if whenHour == .endTime, let startTime = workHour.startTime, dateStr == startTime {
                self.showMessage(message: "출근 시간과 같아요. 시간을 다시 설정해주세요.", controller: self, bottomInset: 112)
                return
            }
        }
        
        if(whenHour == .startTime){
            timeDateModalDelegate?.openTimeTextFieldData(data: dateStr, index: self.index)
        }else{
            timeDateModalDelegate?.endTimeTextFieldData(data: dateStr, index: self.index)
        }
        
        timeDateModalDelegate?.timeModalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        timeDateModalDelegate?.timeModalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        timeDateModalDelegate?.timeModalDismiss()
            self.dismiss(animated: true, completion: nil)
    }
   
}
extension RegisterSelectTimeVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.pickerView){
            return date1.count
        }else {
            return date2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == self.pickerView){
            return date1[row]
        }else {
            return date2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == self.pickerView){
            selectedDate1 = row
        }else {
            selectedDate2 = row
        }
        
    }
    
    // 피커뷰 배경색 지우기
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            pickerView.subviews.forEach {
                $0.backgroundColor = .clear
            }
            
            let numberLabel = UILabel()
            numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 25, weight: .semibold)
            numberLabel.textColor = .black
        
        if(pickerView == self.pickerView){
            numberLabel.text = date1[row]
        }else{
            numberLabel.text = date2[row]
        }
            
            
            return numberLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 48.0
    }
}
