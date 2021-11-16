//
//  MyPageManagerWorkerCollectionViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/02.
//

import UIKit
import Kingfisher

class MyPageManagerWorkerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var workerView: UIView!
    @IBOutlet var workerImage: UIImageView!
    @IBOutlet var workerPositionLabel: UILabel!
    @IBOutlet var workerNameLabel: UILabel!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var workerRankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(data: MyPageManagerContentData){
        workerPositionLabel.text = data.title!
        workerRankLabel.text = data.rank!
        //status 0 일때!(등록 이전)
        if data.status == 0{
            workerView.borderColor = #colorLiteral(red: 0.9983271956, green: 0.9391894341, blue: 0.7339757681, alpha: 1)
            alertImage.isHidden = true
            workerImage.image = #imageLiteral(resourceName: "imgProfileNone84Px")
            workerNameLabel.text = "등록하기"
        }else{
            workerView.borderColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            //이미지 갱신
            //print("img: \(data.imagePath!)")
            if  data.imagePath != nil {
                print("img: \(data.imagePath!)")
                let url = URL(string: data.imagePath!)
                workerImage.kf.setImage(with: url)
            }else{
                    workerImage.image = #imageLiteral(resourceName: "imgProfile84Px1")
            }
            
            workerNameLabel.text = data.first_name!
            
            
            //status 1 일때! (등록 상태)
            if data.status == 1{
                    alertImage.isHidden = true
                    
            }else{ //status 2 일때! (퇴사 요청 상태)
                    alertImage.isHidden = false
            }
        
        }
    }
}
