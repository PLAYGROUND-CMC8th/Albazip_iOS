//
//  MyPageManagerNoWriteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/08.
//

import UIKit

class MyPageManagerNoWriteTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
