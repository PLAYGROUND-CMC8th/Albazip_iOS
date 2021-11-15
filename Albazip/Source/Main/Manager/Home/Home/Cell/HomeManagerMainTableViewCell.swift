//
//  HomeManagerMainTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import UIKit
protocol HomeManagerAddWorkDelegate {
    func goAddWorkPage()
}
class HomeManagerMainTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var honeyImage: UIImageView!
    @IBOutlet var btnAddWork: UIButton!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    var delegate: HomeManagerAddWorkDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //status에 따라 높이, 버튼 유무 조절하면 될듯!
        btnAddWork.isHidden = true
        heightConstraint.constant = 91
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAddWork(_ sender: Any) {
        delegate?.goAddWorkPage()
    }
    
}
