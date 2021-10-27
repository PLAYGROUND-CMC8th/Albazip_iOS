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
    
    static let identifier = "OnboardingWorkerCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "OnboardingWorkerCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(title: String, sub: String, imageName: String){
        titleLabel.text = title
        subLabel.text = sub
        imageView.image = UIImage(named: imageName)
    }
}
