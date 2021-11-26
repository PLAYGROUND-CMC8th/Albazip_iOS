//
//  CommunityManagerNoNoticeTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import UIKit

protocol CommunityManagerNoNoticeDelegate {
    func goWritePage()
}
class CommunityManagerNoNoticeTableViewCell: UITableViewCell {
    var delegate: CommunityManagerNoNoticeDelegate?
    @IBOutlet var btnAddNotice: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddNotice(_ sender: Any) {
        delegate?.goWritePage()
    }
}
