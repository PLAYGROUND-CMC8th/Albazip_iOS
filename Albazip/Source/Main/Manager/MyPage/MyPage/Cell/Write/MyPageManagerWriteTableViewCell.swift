//
//  MyPageManagerWriteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/31.
//

import UIKit

class MyPageManagerWriteTableViewCell: UITableViewCell {

    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var pinImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
