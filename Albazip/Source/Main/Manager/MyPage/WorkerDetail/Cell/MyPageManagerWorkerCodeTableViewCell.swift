//
//  MyPageManagerWorkerCodeTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import UIKit

class MyPageManagerWorkerCodeTableViewCell: UITableViewCell {

    @IBOutlet var codeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCopy(_ sender: Any) {
    }
    
}