//
//  RegisterSelectSalaryDateVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/26.
//

import Foundation
import UIKit

protocol SalaryModalDelegate {
    func modalDismiss()
    func textFieldData(data: String)
}


class RegisterSelectSalaryDateVC: UIViewController{
    
    
    @IBOutlet var cornerView: UIView!
    @IBOutlet var pickerView: UIPickerView!
    
    var salaryModalDelegate : SalaryModalDelegate?
    var dates =  [String]()
    var selectedDate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in (1..<32) {
            dates.append("\(i)")
        }
        setDelegate()
        
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func setDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        salaryModalDelegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        salaryModalDelegate?.textFieldData(data: dates[selectedDate])
        salaryModalDelegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension RegisterSelectSalaryDateVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return dates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = row
    }
    
    // 피커뷰 배경색 지우기
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            pickerView.subviews.forEach {
                $0.backgroundColor = .clear
            }
            
            let numberLabel = UILabel()
            numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            numberLabel.textColor = .black
            numberLabel.text = dates[row]
            
            return numberLabel
    }
}
