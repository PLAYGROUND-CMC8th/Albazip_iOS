//
//  MyPageManagerNoWorkerTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

//공지사항, 게시판 탭 바꿔주는 델리게이트
protocol MyPageManagerNoWorkerDelegate {
    func goAddWorkerPage()
}

class MyPageManagerNoWorkerTableViewCell: UITableViewCell {

    var delegate: MyPageManagerNoWorkerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAddWorker(_ sender: Any) {
        self.delegate?.goAddWorkerPage()
    }
    
}
