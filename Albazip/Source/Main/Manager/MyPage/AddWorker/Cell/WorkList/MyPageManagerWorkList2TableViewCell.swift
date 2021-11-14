//
//  MyPageManagerWorkList2TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

protocol MyPageManagerWorkList2Delegate {
    func deleteCell(index:Int)
    
    func setTitleTextField(index: Int, text:String)
    func setSubTextField(index: Int, text:String)
}

class MyPageManagerWorkList2TableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var textView: UIView!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var subLabel: UITextField!
    var cellIndex: Int?
    var myPageManagerWorkList2Delegate: MyPageManagerWorkList2Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.addTarget(self, action: #selector(self.textFieldDidChange(_:)),  for: .editingChanged)
        subLabel.addTarget(self, action: #selector(self.textFieldDidChange2(_:)),  for: .editingChanged)
        titleLabel.delegate = self
        subLabel.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDelete(_ sender: Any) {
        print(cellIndex!)
        myPageManagerWorkList2Delegate?.deleteCell(index: cellIndex!)
        //myPageManagerWorkList2Delegate?.deleteCell2(self)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
           print(self.titleLabel.text!)
        titleLabel.becomeFirstResponder()
        myPageManagerWorkList2Delegate?.setTitleTextField(index: cellIndex!, text: self.titleLabel.text!)
        textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
    }
    @objc func textFieldDidChange2(_ sender: Any?) {
           print(self.subLabel.text!)
        subLabel.becomeFirstResponder()
        myPageManagerWorkList2Delegate?.setSubTextField(index: cellIndex!, text: self.subLabel.text!)
        textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
    }
    
    // 텍스트 필드의 편집을 시작할 때 호출
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 시작됩니다.")
            textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
            return true // false를 리턴하면 편집되지 않는다.
        }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            print("텍스트 필드의 리턴키가 눌러졌습니다.")
            textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            return true
        }
        
        // 텍스트 필드 편집이 종료될 때 호출
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 종료됩니다.")
            textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            return true
        }
        
        // 텍스트 필드의 편집이 종료되었을 때 호출
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("텍스트 필드의 편집이 종료되었습니다.")
            textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }

}

