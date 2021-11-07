//
//  MyPageManagerSelectInfo2TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

protocol MyPageManagerTimeDateModalDelegate {
    func goSelectTimeDate(index:Int)
    func checkValue2(value: Bool)
    func setBreaktime(text:String)
}

class MyPageManagerSelectInfo2TableViewCell: UITableViewCell {

    
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var endButton: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    
    
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
    
    @IBAction func btn1(_ sender: Any) {
        btn1.isSelected.toggle()
        if btn1.isSelected{
            btn1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2.backgroundColor = .none
            btn2.isSelected = false
            btn3.backgroundColor = .none
            btn3.isSelected = false
            btn4.backgroundColor = .none
            btn4.isSelected = false
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "없음")
        }else{
            btn1.backgroundColor = .none
        }
        checkButton()
    }
    
    @IBAction func btn2(_ sender: Any) {
        btn2.isSelected.toggle()
        if btn2.isSelected{
            btn2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn1.backgroundColor = .none
            btn1.isSelected = false
            btn3.backgroundColor = .none
            btn3.isSelected = false
            btn4.backgroundColor = .none
            btn4.isSelected = false
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "30분")
        }else{
            btn2.backgroundColor = .none
        }
        checkButton()
    }
    @IBAction func btn3(_ sender: Any) {
        btn3.isSelected.toggle()
        if btn3.isSelected{
            btn3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2.backgroundColor = .none
            btn2.isSelected = false
            btn1.backgroundColor = .none
            btn1.isSelected = false
            btn4.backgroundColor = .none
            btn4.isSelected = false
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "60분")
        }else{
            btn3.backgroundColor = .none
        }
        checkButton()
    }
    @IBAction func btn4(_ sender: Any) {
        btn4.isSelected.toggle()
        if btn4.isSelected{
            btn4.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2.backgroundColor = .none
            btn2.isSelected = false
            btn3.backgroundColor = .none
            btn3.isSelected = false
            btn1.backgroundColor = .none
            btn1.isSelected = false
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "90분")
        }else{
            btn4.backgroundColor = .none
        }
        checkButton()
    }
    
    func checkButton(){
        if !btn1.isSelected, !btn2.isSelected, !btn3.isSelected, !btn4.isSelected{
            myPageManagerTimeDateModalDelegate?.checkValue2(value: false)
        }else{
            myPageManagerTimeDateModalDelegate?.checkValue2(value: true)
        }
    }
    
}
