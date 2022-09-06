//
//  SelectWorkerScheduleCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/04.
//

import UIKit
import SnapKit
import Then

class SelectWorkerScheduleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCellStyle() {
    }
    
    private func setupViews() {}
    
    private func setupLayouts() {}
}
