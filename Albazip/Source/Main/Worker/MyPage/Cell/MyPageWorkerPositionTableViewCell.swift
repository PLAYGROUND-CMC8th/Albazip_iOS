//
//  MyPageWorkerPositionTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

class MyPageWorkerPositionTableViewCell: UITableViewCell {

    @IBOutlet var workTimeLabel: UILabel!
    @IBOutlet var breakTimeLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var workDayLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
