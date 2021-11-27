//
//  HomeManagerStoreListTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import UIKit
protocol HomeManagerStoreListDelegate {
    func goEditPage()
    func goDetailPage()
}
class HomeManagerStoreListTableViewCell: UITableViewCell {

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
        delegate?.goEditPage()
    }
    @IBAction func btnDelete(_ sender: Any) {
        delegate?.goDetailPage()
    }
    
}
