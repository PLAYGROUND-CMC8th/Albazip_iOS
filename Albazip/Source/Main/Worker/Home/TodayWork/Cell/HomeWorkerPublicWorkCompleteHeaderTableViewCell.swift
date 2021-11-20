//
//  HomeWorkerPublicWorkCompleteHeaderTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

import UIKit

class HomeWorkerPublicWorkCompleteHeaderTableViewCell: UITableViewCell {

    @IBOutlet var personView: UIView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var peopleCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func personViewTapped(sender: UITapGestureRecognizer) {
        print("몇명일까요")
    }
}
