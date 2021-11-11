//
//  MyPageWorkerWriteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

class MyPageWorkerWriteTableViewCell: UITableViewCell {

    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var commentCountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
