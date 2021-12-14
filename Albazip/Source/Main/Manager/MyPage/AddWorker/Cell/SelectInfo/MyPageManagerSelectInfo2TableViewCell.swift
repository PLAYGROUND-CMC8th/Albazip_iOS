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
            btnSelected(btn: btn1)
            btnUnSelected(btn: btn2)
            btnUnSelected(btn: btn3)
            btnUnSelected(btn: btn4)
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "없음")
        }else{
            btnUnSelected(btn: btn1)
        }
        checkButton()
    }
    
    @IBAction func btn2(_ sender: Any) {
        btn2.isSelected.toggle()
        if btn2.isSelected{
            btnSelected(btn: btn2)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn3)
            btnUnSelected(btn: btn4)
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "30분")
        }else{
            btnUnSelected(btn: btn2)
        }
        checkButton()
    }
    @IBAction func btn3(_ sender: Any) {
        btn3.isSelected.toggle()
        if btn3.isSelected{
            btnSelected(btn: btn3)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn2)
            btnUnSelected(btn: btn4)
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "60분")
        }else{
            btnUnSelected(btn: btn3)
        }
        checkButton()
    }
    @IBAction func btn4(_ sender: Any) {
        btn4.isSelected.toggle()
        if btn4.isSelected{
            btnSelected(btn: btn4)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn3)
            btnUnSelected(btn: btn2)
            myPageManagerTimeDateModalDelegate?.setBreaktime(text: "90분")
        }else{
            btnUnSelected(btn: btn4)
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
    func setCell(data:MyPageManagerEditWorkerData ){
        if data.breakTime == "없음"{
            btnSelected(btn: btn1)
            btnUnSelected(btn: btn4)
            btnUnSelected(btn: btn2)
            btnUnSelected(btn: btn3)
        }else if data.breakTime == "30분"{
            btnSelected(btn: btn2)
            btnUnSelected(btn: btn4)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn3)
        }else if data.breakTime == "60분"{
            btnSelected(btn: btn3)
            btnUnSelected(btn: btn2)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn4)
        }else{
            btnSelected(btn: btn4)
            btnUnSelected(btn: btn2)
            btnUnSelected(btn: btn1)
            btnUnSelected(btn: btn3)
        }
    }
    
    //Disabled 버튼
    func btnDisabled(btn : UIButton){
        btn.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.borderColor =  #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.isEnabled = false
        btn.isSelected = false
    }
    
    //Selected 버튼
    func btnSelected(btn : UIButton){
        btn.setTitleColor(#colorLiteral(red: 0.203897506, green: 0.2039385736, blue: 0.2081941962, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.borderColor =  #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.isSelected = true
        btn.isEnabled = true
    }
    
    //UnSelected 버튼
    func btnUnSelected(btn : UIButton){
        btn.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
        btn.backgroundColor = .none
        btn.borderColor =  #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.isSelected = false
        btn.isEnabled = true
    }
}
