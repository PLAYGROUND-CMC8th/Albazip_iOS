//
//  HomeManagerTodayWorkOpenDeleteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//
protocol HomeManagerTodayWorkOpenDeleteDelegate : AnyObject{
    func deletePublicWorkAlert(index: Int)
}
import UIKit

class HomeManagerTodayWorkOpenDeleteTableViewCell: UITableViewCell {
    weak var delegate : HomeManagerTodayWorkOpenDeleteDelegate?
    var cellIndex: Int?
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var writerNameLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        self.delegate?.deletePublicWorkAlert(index: cellIndex!)
    }
}
