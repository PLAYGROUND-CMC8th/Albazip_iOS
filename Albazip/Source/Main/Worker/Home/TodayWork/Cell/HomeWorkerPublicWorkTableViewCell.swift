//
//  HomeWorkerPublicWorkTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/20.
//

import UIKit
protocol CheckUnCompleteWorkDelegate{
    func checkUnCompleteWork(taskId:Int)
}
class HomeWorkerPublicWorkTableViewCell: UITableViewCell {
    var delegate :CheckUnCompleteWorkDelegate?
    var taskId = -1
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCheck(_ sender: Any) {
        //btnCheck.isSelected.toggle()
        delegate?.checkUnCompleteWork(taskId: taskId)
    }
}
