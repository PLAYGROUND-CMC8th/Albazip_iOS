//
//  HomeManagerAddPrivateWorkCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/14.
//
protocol HomeManagerAddPrivateWorkCollectionViewCellDelegate{
    func positionCellClicked(index: Int)
}
import UIKit

class HomeManagerAddPrivateWorkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var view: UIView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var index = -1
    var delegate :HomeManagerAddPrivateWorkCollectionViewCellDelegate?
    //static let identifier = "CollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        print("셀 선택")
        self.delegate?.positionCellClicked(index: index)
    }
    func setCell(){
        
    }
}
