//
//  HomeManagerWorkPrivateTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

import UIKit

class HomeManagerWorkPrivateTableViewCell: UITableViewCell {

    @IBOutlet var totalCount: UILabel!
    @IBOutlet var completeCount: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progress: UIProgressView!
    @IBOutlet var honeyView: UIView!
    @IBOutlet var honeyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        honeyView.asCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
