//
//  MyPageManagerWorkerPositionTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import UIKit

class MyPageManagerWorkerPositionTableViewCell: UITableViewCell {

    @IBOutlet var workTimeLabel: UILabel!
    @IBOutlet var breakTimeLabel: UILabel!
    @IBOutlet var workDayLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
