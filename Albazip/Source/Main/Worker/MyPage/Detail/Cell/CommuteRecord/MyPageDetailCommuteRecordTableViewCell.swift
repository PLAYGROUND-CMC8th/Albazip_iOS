//
//  MyPageDetailCommuteRecordTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

class MyPageDetailCommuteRecordTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    @IBOutlet var startFlagView: UIImageView!
    @IBOutlet var endFlagView: UIImageView!
    @IBOutlet var startTitle: UILabel!
    @IBOutlet var endTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
