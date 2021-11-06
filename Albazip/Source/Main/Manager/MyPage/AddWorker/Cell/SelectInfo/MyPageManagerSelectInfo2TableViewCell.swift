//
//  MyPageManagerSelectInfo2TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

protocol MyPageManagerTimeDateModalDelegate {
    func goSelectTimeDate(index:Int)
}

class MyPageManagerSelectInfo2TableViewCell: UITableViewCell {

    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var endButton: UIButton!
    
    
    var myPageManagerTimeDateModalDelegate : MyPageManagerTimeDateModalDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func btnStart(_ sender: Any) {
        print("// 타임 피커로 이동")
        // 타임 피커로 이동
        myPageManagerTimeDateModalDelegate?.goSelectTimeDate(index: 0)
    }
    
    @IBAction func btnEnd(_ sender: Any) {
        print("// 타임 피커로 이동")
        // 타임 피커로 이동
        myPageManagerTimeDateModalDelegate?.goSelectTimeDate(index: 1)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
