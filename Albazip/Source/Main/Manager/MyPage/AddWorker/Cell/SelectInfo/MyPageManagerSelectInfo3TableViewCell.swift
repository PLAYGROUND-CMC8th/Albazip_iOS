//
//  MyPageManagerSelectInfo3TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

class MyPageManagerSelectInfo3TableViewCell: UITableViewCell {

    @IBOutlet var moneyTypeTextField: UITextField!
    @IBOutlet var moneyTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    func setUI()  {
        moneyTextField.addRightPadding()
        moneyTypeTextField.addLeftPadding()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
