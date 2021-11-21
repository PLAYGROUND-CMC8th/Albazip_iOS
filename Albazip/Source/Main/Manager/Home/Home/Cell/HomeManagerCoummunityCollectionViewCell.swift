//
//  HomeManagerCoummunityCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import UIKit

class HomeManagerCoummunityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCell(boardInfo: HomeWorkerBoardInfo){
        titleLabel.text = boardInfo.title!
    }
}
