//
//  HelpWrittingBottomSheetViewController.swift
//  Albazip
//
//  Created by 김수빈 on 2023/07/16.
//

import Foundation
import UIKit

import SnapKit

class HelpWrittingBottomSheetViewController: BottomSheetViewController {
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .init(hex: 0x343434)
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = """
        방금 설정한 역할의 알바생이
        고정으로 하게 될 업무를 작성해주세요
        """
        $0.numberOfLines = 2
    }
    
    private let taskListTitle = UILabel().then {
        $0.textColor = .init(hex: 0xA3A3A3)
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.text = """
        작성 예시:
        ㅇㅇ카페 평일 오픈 알바생 업무리스트
        """
        $0.numberOfLines = 2
    }
    
    private lazy var conformButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = UIColor(hex: 0xffd85c)
        $0.setTitleColor(UIColor(hex: 0x343434), for: .normal)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didTappedConformButton(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupLayout() {
        contentView.addSubview(contentStackView)
        
        [titleLabel, taskListTitle].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        TaskExamples.allCases.forEach { taskExample in
            let taskListView = UIView().then {
                $0.backgroundColor = .init(hex: 0xF8F8F8)
                $0.layer.cornerRadius = 20
            }
            
            let paragraphStyle = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.33
                $0.lineSpacing = 0
            }
            
            let taskListLabel = UILabel().then {
                $0.numberOfLines = 0
                $0.textColor = .init(hex: 0x6F6F6F)
                $0.font = .systemFont(ofSize: 15, weight: .medium)
                $0.attributedText = NSMutableAttributedString(
                    string: taskExample.taskString,
                    attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
                )
            }
            
            contentStackView.addArrangedSubview(taskListView)
            taskListView.addSubview(taskListLabel)
            taskListLabel.snp.makeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview().inset(20)
                $0.directionalVerticalEdges.equalToSuperview().inset(16)
            }
        }
        
        contentStackView.addArrangedSubview(conformButton)
    }
    
    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.directionalVerticalEdges.equalToSuperview().inset(36)
        }
        
        conformButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        contentStackView.setCustomSpacing(14, after: titleLabel)
        contentStackView.setCustomSpacing(12, after: taskListTitle)
    }

    @objc
    func didTappedConformButton(_ sender: UIButton) {
        dismissBottomSheet()
    }
}

extension HelpWrittingBottomSheetViewController {
    enum TaskExamples: CaseIterable {
      case task1
      case task2
      case task3
      
      var taskString: String {
          switch self {
          case .task1:
              return """
              업무명: 간판 밖으로 내놓기
              설명: 매장 앞 나무 주변에 놓아주세요.
              """
          case .task2:
              return """
              업무명: 원두, 커피머신 쇼케이스 전원 끄기
              설명: 원두는 1번과 3번 동시에 누르면 되고 커피 머신은 2번과 5번 버튼을 동시에 눌러주세요.
              """
          case .task3:
              return """
              업무명: 실내 등 조명 끄기
              설명: 스위치는 매장 문 옆에 있고, 실내등은 오른쪽 두번째 입니다.
              """
          }
      }
  }
}
