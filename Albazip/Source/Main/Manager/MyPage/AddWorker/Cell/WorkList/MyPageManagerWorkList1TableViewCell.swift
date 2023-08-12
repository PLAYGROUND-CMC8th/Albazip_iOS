//
//  MyPageManagerWorkList1TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

import RxSwift

protocol MyPageManagerWorkList1TableViewCellDelegate: AnyObject {
    func showHelpWriteBottomSheet()
}

class MyPageManagerWorkList1TableViewCell: UITableViewCell {
    weak var delegate: MyPageManagerWorkList1TableViewCellDelegate?
    @IBOutlet var helpWriteLabel: UILabel!
    @IBOutlet var cellHeight: NSLayoutConstraint!
    @IBOutlet var cellTitle: UILabel!
    
    @IBOutlet var taskWriteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(helpWriteLabelTapped))
        helpWriteLabel.isUserInteractionEnabled = true
        helpWriteLabel.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc
    func helpWriteLabelTapped() {
        delegate?.showHelpWriteBottomSheet()
    }
    
    func setupTaskWriteLabel(text: String?) {
        guard var str = text else { return }
        
        let index = str.index(str.startIndex, offsetBy: 2)
        str.insert(" ", at: index)
        
        taskWriteLabel.text = "{\(str)} 알바생 업무리스트 작성하기"
    }
}
