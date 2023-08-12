//
//  BottomSheetViewController.swift
//  Albazip
//
//  Created by 김수빈 on 2023/07/16.
//

import UIKit

import RxSwift

class BottomSheetViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .init(hex: 0x000000).withAlphaComponent(0.3)
    }
  
    let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
  
    private let tapGesture = UITapGestureRecognizer(
        target: BottomSheetViewController.self,
        action: nil
    )
  
    override func viewDidLoad() {
        setupLayouts()
        setupConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentBottomSheet()
    }
  
    private func setupLayouts() {
        [backgroundView, contentView].forEach {
          view.addSubview($0)
        }
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupStyles() {
        view.backgroundColor = .clear
    }

    private func bind() {
        tapGesture.rx.event
            .asDriver()
            .drive(with: self) { owner , _ in
                owner.dismissBottomSheet()
          }
          .disposed(by: disposeBag)
        backgroundView.addGestureRecognizer(tapGesture)
    }
}

extension BottomSheetViewController {
    private func presentBottomSheet() {
        contentView.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
        UIView.transition(with: view, duration: 0.25, options: .curveEaseInOut, animations: {
            self.backgroundView.backgroundColor = .init(hex: 0x000000).withAlphaComponent(0.3)
            self.contentView.frame.origin = CGPoint(x: 0, y: 0)
        })
    }
  
    func dismissBottomSheet() {
        UIView.transition(with: view, duration: 0.25, options: .curveEaseInOut, animations: {
            self.backgroundView.backgroundColor = .clear
            self.contentView.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
}
