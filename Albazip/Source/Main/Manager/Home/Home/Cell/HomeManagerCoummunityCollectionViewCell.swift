//
//  HomeManagerCoummunityCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import UIKit

class HomeManagerCoummunityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var statusWidth: NSLayoutConstraint!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 4
    }
    func setCell(boardInfo: HomeWorkerBoardInfo){
        titleLabel.text = boardInfo.title!
        if let x = boardInfo.confirm{ // 근무자일때
            statusWidth.constant = 35
            statusLabel.isHidden = false
            if x == 0{ //미확인
                statusLabel.text = "미확인"
                statusLabel.textColor = #colorLiteral(red: 0.9833402038, green: 0.2258323133, blue: 0, alpha: 1)
                statusLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8983411193, blue: 0.8958156705, alpha: 1)
                statusLabel.borderColor =  #colorLiteral(red: 0.9983271956, green: 0.9391896129, blue: 0.7384549379, alpha: 1)
            }else{ //확인
                statusLabel.text = "확인"
                statusLabel.textColor = #colorLiteral(red: 0.1636831164, green: 0.7599473596, blue: 0.3486425281, alpha: 1)
                statusLabel.backgroundColor = #colorLiteral(red: 0.8957179189, green: 0.9912716746, blue: 0.9204327464, alpha: 1)
                statusLabel.borderColor =  #colorLiteral(red: 0.9293201566, green: 0.9294758439, blue: 0.9292996526, alpha: 1)
            }
        }else{ // 관리자일때
            statusWidth.constant = 0
            statusLabel.isHidden = true
        }
    }
}
