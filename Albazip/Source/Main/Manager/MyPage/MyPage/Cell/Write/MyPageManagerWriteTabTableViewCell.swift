//
//  MyPageManagerWriteTabTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

//공지사항, 게시판 탭 바꿔주는 델리게이트
protocol MyPageManagerWriteTabDelegate {
    func changeTab(index: Int)
}

class MyPageManagerWriteTabTableViewCell: UITableViewCell {

    @IBOutlet var btnNotice: UIButton!
    @IBOutlet var btnCoummunity: UIButton!
    var delegate: MyPageManagerWriteTabDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnNotice(_ sender: Any) {
        btnNotice.setTitleColor(#colorLiteral(red: 0.9982766509, green: 0.6176742315, blue: 0, alpha: 1), for: .normal)
        btnCoummunity.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
        self.delegate?.changeTab(index: 0)
    }
    
    @IBAction func btnCommunity(_ sender: Any) {
        btnCoummunity.setTitleColor(#colorLiteral(red: 0.9982766509, green: 0.6176742315, blue: 0, alpha: 1), for: .normal)
        btnNotice.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
        self.delegate?.changeTab(index: 1)
    }
    
}
