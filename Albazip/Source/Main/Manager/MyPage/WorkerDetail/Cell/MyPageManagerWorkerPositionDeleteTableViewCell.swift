//
//  MyPageManagerWorkerPositionDeleteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//
protocol MyPageManagerWorkerPositionDeleteDelegate {
    func deletePosition()
}

import UIKit

class MyPageManagerWorkerPositionDeleteTableViewCell: UITableViewCell {

    @IBOutlet var btnDelete: UIButton!
    var myPageManagerWorkerPositionDeleteDelegate:MyPageManagerWorkerPositionDeleteDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDelete(_ sender: Any) {
        myPageManagerWorkerPositionDeleteDelegate?.deletePosition()
    }
    
    
}
