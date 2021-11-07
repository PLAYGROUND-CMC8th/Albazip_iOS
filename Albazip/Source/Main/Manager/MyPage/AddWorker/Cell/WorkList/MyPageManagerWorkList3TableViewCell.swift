//
//  MyPageManagerWorkList3TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

protocol MyPageManagerWorkList3Delegate {
    func addWork()
}
import UIKit

class MyPageManagerWorkList3TableViewCell: UITableViewCell {

    var myPageManagerWorkList3Delegate: MyPageManagerWorkList3Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddWork(_ sender: Any) {
        myPageManagerWorkList3Delegate?.addWork()
    }
}
