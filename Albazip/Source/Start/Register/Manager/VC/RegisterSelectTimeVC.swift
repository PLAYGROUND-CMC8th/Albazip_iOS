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
    func openTimeTextFieldData(data: String)
    func endTimeTextFieldData(data: String)
}

class RegisterSelectTimeVC: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
   
    @IBOutlet var cornerView: UIView!
    @IBOutlet var pickerView2: UIPickerView!
    
    var titletext = ""
    var timeDateModalDelegate : TimeDateModalDelegate?
    var date1 =  [String]()
    var date2 =  [String]()
    var selectedDate1 = 0
    var selectedDate2 = 0
    //0 이면 오픈시간 1이면 마감시간
    var whatDate = 0
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
        titleLabel.text = titletext
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
   
    @IBAction func btnNext(_ sender: Any) {
        if(whatDate == 0){
            timeDateModalDelegate?.openTimeTextFieldData(data: date1[selectedDate1]+":"+date2[selectedDate2])
        }else{
            timeDateModalDelegate?.endTimeTextFieldData(data: date1[selectedDate1]+":"+date2[selectedDate2])
        }
        
        timeDateModalDelegate?.timeModalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
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
