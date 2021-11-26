//
//  CommunityManagerWriteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import UIKit

protocol CommunityManagerWriteDelegate {
    func setTitleTextField(text:String)
    func setSubTextField(text:String)
}

class CommunityManagerWriteTableViewCell: UITableViewCell , UITextFieldDelegate{
    var delegate: CommunityManagerWriteDelegate?
    @IBOutlet var labelCountTextField: UILabel!
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var realTimeCountLabel: UILabel!
    @IBOutlet var subTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextField.addLeftPadding()
        subTextField.addLeftPadding()
        titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),  for: .editingChanged)
        subTextField.addTarget(self, action: #selector(self.textFieldDidChange2(_:)),  for: .editingChanged)
        titleTextField.delegate = self
        subTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func textFieldDidChange(_ sender: Any?) {
           print(self.titleTextField.text!)
        titleTextField.becomeFirstResponder()
        delegate?.setTitleTextField( text: self.titleTextField.text!)
        titleTextField.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
    }
    @objc func textFieldDidChange2(_ sender: Any?) {
           print(self.subTextField.text!)
        subTextField.becomeFirstResponder()
        delegate?.setSubTextField(text: self.subTextField.text!)
        subTextField.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
        realTimeCountLabel.text = String(subTextField.text!.count)
    }
    
    // 텍스트 필드의 편집을 시작할 때 호출
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 시작됩니다.")
            textField.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
            return true // false를 리턴하면 편집되지 않는다.
        }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            print("텍스트 필드의 리턴키가 눌러졌습니다.")
            textField.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            return true
        }
        
        // 텍스트 필드 편집이 종료될 때 호출
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 종료됩니다.")
            textField.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            return true
        }
        
        // 텍스트 필드의 편집이 종료되었을 때 호출
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("텍스트 필드의 편집이 종료되었습니다.")
            textField.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }
}
