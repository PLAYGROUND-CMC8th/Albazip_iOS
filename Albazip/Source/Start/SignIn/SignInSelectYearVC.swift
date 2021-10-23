//
//  SignInSelectYearVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/22.
//

import Foundation
import UIKit

protocol ModalViewControllerDelegate{
    func modalDidFinished(modalText: String)
}

class SignInSelectYearVC: UIViewController{
    
    var date = "2000"
    @IBOutlet var picker: UIPickerView!
    var delegate: ModalViewControllerDelegate?
    var dates =  [String]()
    
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
        dismiss(animated: false, completion: nil)
    }
    @IBAction func btnNext(_ sender: Any) {
        self.delegate?.modalDidFinished(modalText: date)
        dismiss(animated: false, completion: nil)
    }
    
}

extension SignInSelectYearVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dates[row]
    }
    /*
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            var color: UIColor!
        if pickerView.selectedRow(inComponent: component) == row {
                color = #colorLiteral(red: 0.9991409183, green: 0.9350906014, blue: 0.7388775945, alpha: 1)
            } else {
                color = .none
            }

            let attributes: [String: AnyObject] = [
                NSForegroundColorAttributeName: color,
                NSFontAttributeName: UIFont.systemFontOfSize(15)
            ]

            return NSAttributedString(string: date[row], attributes: attributes)
        }*/
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dates[row])
        // Date that the user select.
        date = dates[row]
        pickerView.reloadAllComponents()
    }
}


