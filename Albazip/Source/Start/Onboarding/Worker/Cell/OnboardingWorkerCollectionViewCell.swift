//
//  OnboardingWorkerCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/27.
//

import UIKit

class OnboardingWorkerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var subLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = String(describing: OnboardingWorkerCollectionViewCell.self)
    
    
    func setup(_ slide: OnboardingData){
        titleLabel.text = slide.title
        subLabel.text = slide.description
        imageView.image = slide.image
    }
}
