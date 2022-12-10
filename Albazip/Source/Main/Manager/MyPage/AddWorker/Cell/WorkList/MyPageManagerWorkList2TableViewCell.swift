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
    func updateTextViewHeight(_ cell: UITableViewCell, _ textView: UITextView)
}

class MyPageManagerWorkList2TableViewCell: UITableViewCell {

    @IBOutlet var textView: UIView!
    @IBOutlet var titleLabel: UITextField!
    
    @IBOutlet var subTextView: UITextView!
    @IBOutlet var subLabel: UILabel!
    
    var cellIndex: Int?
    
    var myPageManagerWorkList2Delegate: MyPageManagerWorkList2Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.addTarget(self, action: #selector(self.textFieldDidChange(_:)),  for: .editingChanged)
        titleLabel.delegate = self
        subTextView.delegate = self
        subTextView.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func btnDelete(_ sender: Any) {
        print(cellIndex!)
        myPageManagerWorkList2Delegate?.deleteCell(index: cellIndex!)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
           print(self.titleLabel.text!)
        titleLabel.becomeFirstResponder()
        myPageManagerWorkList2Delegate?.setTitleTextField(index: cellIndex!, text: self.titleLabel.text!)
        textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
    }
    
    func setUpData(work: WorkList, index: Int) {
        self.selectionStyle = .none
        self.cellIndex = index
        self.titleLabel.text = work.title
        self.subTextView.text = work.content
        let textStr = subTextView.text ?? ""
        if textStr == "" {
            subLabel.isHidden = false
        }else {
            subLabel.isHidden = true
        }
    }
    
    func setUpData(work: EditWorkList, index: Int) {
        self.selectionStyle = .none
        self.cellIndex = index
        self.titleLabel.text = work.title
        self.subTextView.text = work.content ?? ""
        let textStr = subTextView.text ?? ""
        if textStr == "" {
            subLabel.isHidden = false
        }else {
            subLabel.isHidden = true
        }
    }
}
extension MyPageManagerWorkList2TableViewCell:  UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
        return true // false를 리턴하면 편집되지 않는다.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
    }
}
extension MyPageManagerWorkList2TableViewCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
        subLabel.isHidden = true
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        let textStr = self.subTextView.text ?? ""
        if textStr == "" {
            subLabel.isHidden = false
        }else {
            subLabel.isHidden = true
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textView.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        let textStr = self.subTextView.text ?? ""
        if textStr == "" {
            subLabel.isHidden = false
        }else {
            subLabel.isHidden = true
        }
    }
    func textViewDidChange(_ textView: UITextView){
        subTextView.becomeFirstResponder()
        self.textView.borderColor = #colorLiteral(red: 0.6391510963, green: 0.6392608881, blue: 0.6391366124, alpha: 1)
        let textStr = self.subTextView.text ?? ""
        myPageManagerWorkList2Delegate?.setSubTextField(index: cellIndex!, text: textStr)
        myPageManagerWorkList2Delegate?.updateTextViewHeight(self, textView)
    }
}
