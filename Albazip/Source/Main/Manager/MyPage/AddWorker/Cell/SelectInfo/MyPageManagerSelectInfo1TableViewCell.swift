//
//  MyPageManagerSelectInfo1TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit

protocol MyPageManagerSelectInfo1Delegate {
    func presentAlert(text:String)
    func openView()
    func closeView()
}

class MyPageManagerSelectInfo1TableViewCell: UITableViewCell {

    // 직급
    @IBOutlet var btn1_1: UIButton!
    @IBOutlet var btn1_2: UIButton!
    
    //포지션(평일, 주말)
    @IBOutlet var btn2_1: UIButton!
    @IBOutlet var btn2_2: UIButton!
    @IBOutlet var btn2_3: UIButton!
    @IBOutlet var btn2_4: UIButton!
    //포지션(오픈, 미들, 마감)
    @IBOutlet var btn3_1: UIButton!
    @IBOutlet var btn3_2: UIButton!
    @IBOutlet var btn3_3: UIButton!
    
    // 스케줄
    @IBOutlet var btn4_1: UIButton!
    @IBOutlet var btn4_2: UIButton!
    @IBOutlet var btn4_3: UIButton!
    @IBOutlet var btn4_4: UIButton!
    @IBOutlet var btn4_5: UIButton!
    @IBOutlet var btn4_6: UIButton!
    @IBOutlet var btn4_7: UIButton!
    @IBOutlet var btn4_8: UIButton!
    
    //
    var myPageManagerSelectInfo1Delegate: MyPageManagerSelectInfo1Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn1_1(_ sender: Any) {
        btn1_1.isSelected.toggle()
        if btn1_1.isSelected{
            btn1_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            //직원
            btn1_2.isEnabled = false
            btn1_2.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            //매니저, 점장
            btn2_3.isEnabled = false
            btn2_3.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            btn2_4.isEnabled = false
            btn2_4.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            //교대근무
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn1_1.backgroundColor = .none
            btn1_2.isEnabled = true
            btn1_2.backgroundColor = .none
            
            //직원
            btn1_2.isEnabled = true
            btn1_2.backgroundColor = .none
            //매니저, 점장
            btn2_3.isEnabled = true
            btn2_3.backgroundColor = .none
            btn2_4.isEnabled = true
            btn2_4.backgroundColor = .none
            //교대근무
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
    }
    
    @IBAction func btn1_2(_ sender: Any) {
        myPageManagerSelectInfo1Delegate?.presentAlert(text: "해당 직군은 유료서비스로 아직 준비중 입니다 :)")
    }
    
    @IBAction func btn2_1(_ sender: Any) {
        btn2_1.isSelected.toggle()
        if btn2_1.isSelected{
            btn2_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2_2.backgroundColor = .none
            btn2_2.isSelected = false
        }else{
            btn2_1.backgroundColor = .none
        }
    }
    @IBAction func btn2_2(_ sender: Any) {
        btn2_2.isSelected.toggle()
        if btn2_2.isSelected{
            btn2_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2_1.backgroundColor = .none
            btn2_1.isSelected = false
        }else{
            btn2_2.backgroundColor = .none
        }
    }
    
    @IBAction func btn2_3(_ sender: Any) {
        myPageManagerSelectInfo1Delegate?.presentAlert(text: "해당 직군은 유료서비스로 아직 준비중 입니다 :)")
    }
    @IBAction func btn2_4(_ sender: Any) {
        myPageManagerSelectInfo1Delegate?.presentAlert(text: "해당 직군은 유료서비스로 아직 준비중 입니다 :)")
    }
    
    // 포지션(오픈, 미들, 마감)
    @IBAction func btn3_1(_ sender: Any) {
        btn3_1.isSelected.toggle()
        if btn3_1.isSelected{
            btn3_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_2.backgroundColor = .none
            btn3_2.isSelected = false
            btn3_3.backgroundColor = .none
            btn3_3.isSelected = false
        }else{
            btn3_1.backgroundColor = .none
        }
    }
    @IBAction func btn3_2(_ sender: Any) {
        btn3_2.isSelected.toggle()
        if btn3_2.isSelected{
            btn3_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
            btn3_3.backgroundColor = .none
            btn3_3.isSelected = false
        }else{
            btn3_2.backgroundColor = .none
        }
    }
    @IBAction func btn3_3(_ sender: Any) {
        btn3_3.isSelected.toggle()
        if btn3_3.isSelected{
            btn3_3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_2.backgroundColor = .none
            btn3_2.isSelected = false
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
        }else{
            btn3_3.backgroundColor = .none
        }
    }
    
    //스케줄 입력
    @IBAction func btn4_1(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_1.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_1.isSelected{
            btn4_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_1.backgroundColor = .none
        }
    }
    @IBAction func btn4_2(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_2.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_2.isSelected{
            btn4_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_2.backgroundColor = .none
        }
    }
    @IBAction func btn4_3(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_3.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_3.isSelected{
            btn4_3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_3.backgroundColor = .none
        }
    }
    @IBAction func btn4_4(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_4.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_4.isSelected{
            btn4_4.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_4.backgroundColor = .none
        }
    }
    @IBAction func btn4_5(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_5.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_5.isSelected{
            btn4_5.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_5.backgroundColor = .none
        }
    }
    @IBAction func btn4_6(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_6.isSelected.toggle()
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_6.isSelected{
            btn4_6.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_6.backgroundColor = .none
        }
    }
    @IBAction func btn4_7(_ sender: Any) {
        if isNoDaySelected(){//요일이 하나라도 선택 안되어있으면 이제 선택됐으니깐 펼쳐주자..
            myPageManagerSelectInfo1Delegate?.openView()
        }
        btn4_7.isSelected.toggle()
       
        if isNoDaySelected(){  //토글했는데 아무것도 선택 안되어있으면,,,접어주자
            myPageManagerSelectInfo1Delegate?.closeView()
            btn4_8.isEnabled = true
            btn4_8.backgroundColor = .none
        }
        if btn4_7.isSelected{
            btn4_7.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn4_8.isEnabled = false
            btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }else{
            btn4_7.backgroundColor = .none
        }
    }
    
    
    @IBAction func btn4_8(_ sender: Any) {
        myPageManagerSelectInfo1Delegate?.presentAlert(text: "해당 스케줄은 유료서비스로 아직 준비중 입니다 :)")
    }
    
    func isNoDaySelected()-> Bool {
        // 요일 버튼이 모두 선택 안되어있음
        if !btn4_1.isSelected,!btn4_2.isSelected,!btn4_3.isSelected,!btn4_4.isSelected,!btn4_5.isSelected,!btn4_6.isSelected,!btn4_7.isSelected{
            return true
        }else{
            //요일 버튼이 하나라도 선택되어있음
            return false
        }
    }
}
