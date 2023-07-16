//
//  MyPageTooltip.swift
//  Albazip
//
//  Created by 김수빈 on 2023/07/02.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class MyPageTooltip: UIView {
    private lazy var disposeBag = DisposeBag()
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "myPageTooltip")
        $0.contentMode = .scaleAspectFit
        $0.applyShadow(blur: 70, x: 0, y: 3, opacity: 0.1, color: .black)
    }
    
    private let tooltipLabel = UILabel().then {
        $0.text = """
        여기를 누르면
        알바생을 더 추가할 수 있어요!
        """
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.numberOfLines = 2
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "icDeleteGray20Px"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        bind()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [backgroundImageView, tooltipLabel, deleteButton].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.bottom.equalToSuperview().inset(26)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        tooltipLabel.snp.makeConstraints {
            $0.centerY.equalTo(deleteButton.snp.centerY)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-12)
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    private func bind() {
        deleteButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.isHidden = true
            }
            .disposed(by: disposeBag)
    }
}
