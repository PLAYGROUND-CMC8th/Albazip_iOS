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

class MyPageManagerWorkList2TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var subLabel: UITextField!
    var cellIndex: Int?
    var myPageManagerWorkList2Delegate: MyPageManagerWorkList2Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.addTarget(self, action: #selector(self.textFieldDidChange(_:)),  for: .editingChanged)
        subLabel.addTarget(self, action: #selector(self.textFieldDidChange2(_:)),  for: .editingChanged)
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
    }
    @objc func textFieldDidChange2(_ sender: Any?) {
           print(self.subLabel.text!)
        subLabel.becomeFirstResponder()
        myPageManagerWorkList2Delegate?.setSubTextField(index: cellIndex!, text: self.subLabel.text!)
    }
}

