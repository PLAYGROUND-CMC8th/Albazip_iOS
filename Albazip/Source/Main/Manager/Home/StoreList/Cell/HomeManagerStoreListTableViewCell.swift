//
//  HomeManagerStoreListTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import UIKit
protocol HomeManagerStoreListDelegate {
    func goEditPage(managerId:Int)
    func goDetailPage(managerId:Int, index: Int)
}
class HomeManagerStoreListTableViewCell: UITableViewCell {
    var managerId = -1
    var index = -1
    var delegate:  HomeManagerStoreListDelegate?
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var storeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnEdit(_ sender: Any) {
        delegate?.goEditPage(managerId: managerId)
    }
    @IBAction func btnDelete(_ sender: Any) {
        delegate?.goDetailPage(managerId: managerId, index: index)
    }
    
}
