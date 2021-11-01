//
//  RegisterSelectYearVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/22.
//

import Foundation
import UIKit

protocol YearModalDelegate {
    func modalDismiss()
    func textFieldData(data: String)
}

class RegisterSelectYearVC: UIViewController{
    
    var date = "2000"
    @IBOutlet var picker: UIPickerView!
    var delegate: YearModalDelegate?
    var dates =  [String]()
    var selectedDate = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setPickerView()
    }
    func setPickerView() {
        
        for i in (1950..<2021) {
            dates.append("\(i)")
        }
            
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(50, inComponent: 0, animated: false)
    }
    @IBAction func btnCancel(_ sender: Any) {
        delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: Any) {
        delegate?.textFieldData(data: dates[selectedDate])
        delegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterSelectYearVC: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
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
