//
//  HomeWorkerMainTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import UIKit
protocol HomeWorkerAddWorkDelegate {
    func goNextPage()
}
class HomeWorkerMainTableViewCell: UITableViewCell {

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beeImage: UIImageView!
    @IBOutlet var btnNextPage: UIButton!
    var delegate: HomeWorkerAddWorkDelegate?
    //titleLabel
    //dateLabel
    //beeImage
    //btnAddWork
    //heightConstraint
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnNextPage(_ sender: Any) {
        delegate?.goNextPage()
    }
}
