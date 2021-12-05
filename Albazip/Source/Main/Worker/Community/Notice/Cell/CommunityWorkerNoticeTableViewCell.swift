//
//  CommunityWorkerNoticeTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import UIKit

class CommunityWorkerNoticeTableViewCell: UITableViewCell {

  
    @IBOutlet var pinImage: UIImageView!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noticeView: UIView!
    @IBOutlet var checkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkLabel.layer.masksToBounds = true
        checkLabel.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPin(_ sender: Any) {
    }
}
