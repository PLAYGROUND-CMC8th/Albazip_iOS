//
//  CommunityManagerPhotoTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import UIKit
protocol CommunityManagerPhotoDelegate {
    func selectPicture()
    func deleteImage1()
    func deleteImage2()
}
class CommunityManagerPhotoTableViewCell: UITableViewCell {

    @IBOutlet var pickerView: UIView!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var Btndelete1: UIButton!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var Btndelete2: UIButton!
    
    var delegate: CommunityManagerPhotoDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image1.isHidden = true
        image2.isHidden = true
        Btndelete1.isHidden = true
        Btndelete2.isHidden = true
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickerViewTapped))
        pickerView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDelete1(_ sender: Any) {
        delegate?.deleteImage1()
    }
    @IBAction func btnDelete2(_ sender: Any) {
        delegate?.deleteImage2()
    }
    @objc func pickerViewTapped(sender: UITapGestureRecognizer) {
        delegate?.selectPicture()
    }
}
