//
//  MyPageManagerWorkList2TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

protocol MyPageManagerWorkList2Delegate {
    func deleteCell(index:Int)
    //func deleteCell2(_ myPageManagerWorkList2TableViewCell:MyPageManagerWorkList2TableViewCell)
}

class MyPageManagerWorkList2TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var subLabel: UITextField!
    var cellIndex: Int?
    var myPageManagerWorkList2Delegate: MyPageManagerWorkList2Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
}

extension MyPageManagerWorkList2TableViewCell: UITextFieldDelegate{
    
}
