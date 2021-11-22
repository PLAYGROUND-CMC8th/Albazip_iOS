//
//  TodayWorkerListTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/22.
//

import UIKit

class TodayWorkerListTableViewCell: UITableViewCell {

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //이미지뷰 동그랗게
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        // Configure the view for the selected state
    }
    
}
