//
//  OnboardingCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/28.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
        
        @IBOutlet weak var slideImageView: UIImageView!
        @IBOutlet weak var slideTitleLbl: UILabel!
        @IBOutlet weak var slideDescriptionLbl: UILabel!
        
        func setup(_ slide: OnboardingData) {
            slideImageView.image = slide.image
            slideTitleLbl.text = slide.title
            slideDescriptionLbl.text = slide.description
        }
}
