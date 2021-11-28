//
//  CommunityManagerNoticeTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import UIKit
protocol CommunityManagerNoticeDelegate {
    func pinAPI(noticeId:Int)
}
class CommunityManagerNoticeTableViewCell: UITableViewCell {
    var noticeId =  -1
    @IBOutlet var bgView: UIView!
    var delegate: CommunityManagerNoticeDelegate?
    @IBOutlet var noticeView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var btnPin: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnPin(_ sender: Any) {
        delegate?.pinAPI(noticeId: noticeId)
    }
    
}
