//
//  HomeWorkerPublicWorkCompleteTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/20.
//

import UIKit
protocol CheckCompleteWorkDelegate{
    func checkCompleteWork(taskId:Int)
}
class HomeWorkerPublicWorkCompleteTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var btnCheck: UIButton!
    var taskId = -1
    var delegate :CheckCompleteWorkDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCheck(_ sender: Any) {
        delegate?.checkCompleteWork(taskId: taskId)
    }
}
