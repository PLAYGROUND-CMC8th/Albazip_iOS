//
//  MyPageDetailClearWorkTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

class MyPageDetailClearWorkTableViewCell: UITableViewCell {

    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var segment: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
