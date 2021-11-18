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
    func checkValue1(value: Bool)
    func setRank(text:String)
    func setTitle(text:String)
    func setTitle3(text:String)
    func addDay(text:String)
    func deleteDay(text:String)
    
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
            
            myPageManagerSelectInfo1Delegate?.setRank(text: "알바생")
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
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.setTitle3(text: "평일")
        }else{
            btn2_1.backgroundColor = .none
        }
        checkButton()
    }
    @IBAction func btn2_2(_ sender: Any) {
        btn2_2.isSelected.toggle()
        if btn2_2.isSelected{
            btn2_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2_1.backgroundColor = .none
            btn2_1.isSelected = false
            myPageManagerSelectInfo1Delegate?.setTitle3(text: "주말")
        }else{
            btn2_2.backgroundColor = .none
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.setTitle(text: "오픈")
        }else{
            btn3_1.backgroundColor = .none
        }
        checkButton()
    }
    @IBAction func btn3_2(_ sender: Any) {
        btn3_2.isSelected.toggle()
        if btn3_2.isSelected{
            btn3_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
            btn3_3.backgroundColor = .none
            btn3_3.isSelected = false
            myPageManagerSelectInfo1Delegate?.setTitle(text: "미들")
        }else{
            btn3_2.backgroundColor = .none
        }
        checkButton()
    }
    @IBAction func btn3_3(_ sender: Any) {
        btn3_3.isSelected.toggle()
        if btn3_3.isSelected{
            btn3_3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_2.backgroundColor = .none
            btn3_2.isSelected = false
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
            myPageManagerSelectInfo1Delegate?.setTitle(text: "마감")
        }else{
            btn3_3.backgroundColor = .none
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "월")
        }else{
            btn4_1.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "월")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "화")
        }else{
            btn4_2.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "화")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "수")
        }else{
            btn4_3.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "수")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "목")
        }else{
            btn4_4.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "목")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "금")
        }else{
            btn4_5.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "금")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "토")
        }else{
            btn4_6.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "토")
        }
        checkButton()
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
            myPageManagerSelectInfo1Delegate?.addDay(text: "일")
        }else{
            btn4_7.backgroundColor = .none
            myPageManagerSelectInfo1Delegate?.deleteDay(text: "일")
        }
        checkButton()
    }
    
    
    @IBAction func btn4_8(_ sender: Any) {
        myPageManagerSelectInfo1Delegate?.presentAlert(text: "해당 스케줄은 유료서비스로 아직 준비중 입니다 :)")
    }
    
    //요일 버튼 검사
    func isNoDaySelected()-> Bool {
        // 요일 버튼이 모두 선택 안되어있음
        if !btn4_1.isSelected,!btn4_2.isSelected,!btn4_3.isSelected,!btn4_4.isSelected,!btn4_5.isSelected,!btn4_6.isSelected,!btn4_7.isSelected{
            return true
        }else{
            //요일 버튼이 하나라도 선택되어있음
            return false
        }
    }
    
    // 직급 선택 버튼 검사
    func isNoJobSelected()-> Bool {
        //모두 선태 안되어있음
        if !btn1_1.isSelected, !btn1_2.isSelected{
            return true
        }else{
            return false
        }
    }
    
    // 포지션 선택 버튼 검사
    func isPositionSelected()->Bool {
        //모두 선택 안되어있음
        if !btn2_1.isSelected, !btn2_2.isSelected, !btn2_3.isSelected, !btn2_4.isSelected{
            return true
        }else{
            return false
        }
    }
    
    // 포지션 2 선택 버튼 검사
    
    func isPosition2Selected() -> Bool {
        if !btn3_1.isSelected, !btn3_2.isSelected, !btn3_3.isSelected{
            return true
        }else {
             return false
        }
    }
    
    func checkButton(){
        if isNoDaySelected() == false, isPositionSelected() == false, isPosition2Selected() == false, isNoJobSelected() == false{
            //모든 버튼 선택 완료임
            myPageManagerSelectInfo1Delegate?.checkValue1(value: true)
        }else{
            //하나ㅏㄹ도 선택 안되어있음
            myPageManagerSelectInfo1Delegate?.checkValue1(value: false)
        }
    }
    func setCell(data:MyPageManagerEditWorkerData ){
        // 직급
        if data.rank == "알바생"{
            btn1_1.isSelected = true
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
            
            //myPageManagerSelectInfo1Delegate?.setRank(text: "알바생")
        }
        //포지션
        if data.title.contains("오픈"){
            btn3_1.isSelected = true
            btn3_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_2.backgroundColor = .none
            btn3_2.isSelected = false
            btn3_3.backgroundColor = .none
            btn3_3.isSelected = false
            //myPageManagerSelectInfo1Delegate?.setTitle(text: "오픈")
        }else if data.title.contains("미들"){
            btn3_2.isSelected = true
            btn3_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
            btn3_3.backgroundColor = .none
            btn3_3.isSelected = false
            //myPageManagerSelectInfo1Delegate?.setTitle(text: "미들")
        }else{
            btn3_3.isSelected = true
            btn3_3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn3_2.backgroundColor = .none
            btn3_2.isSelected = false
            btn3_1.backgroundColor = .none
            btn3_1.isSelected = false
            //myPageManagerSelectInfo1Delegate?.setTitle(text: "마감")
        }
        
        if data.title.contains("평일"){
            btn2_1.isSelected = true
            btn2_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2_2.backgroundColor = .none
            btn2_2.isSelected = false
        }else{
            btn2_2.isSelected = true
            btn2_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn2_1.backgroundColor = .none
            btn2_1.isSelected = false
        }
        
        
        if data.workDay.contains("월"){
            btn4_1.isSelected = true
            btn4_1.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        if data.workDay.contains("화"){
            btn4_2.isSelected = true
            btn4_2.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        if data.workDay.contains("수"){
            btn4_3.isSelected = true
            btn4_3.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        
        if data.workDay.contains("목"){
            btn4_4.isSelected = true
            btn4_4.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        if data.workDay.contains("금"){
            btn4_5.isSelected = true
            btn4_5.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        if data.workDay.contains("토"){
            btn4_6.isSelected = true
            btn4_6.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }
        if data.workDay.contains("일"){
            btn4_7.isSelected = true
            btn4_7.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            //myPageManagerSelectInfo1Delegate?.addDay(text: "일")
        }
        btn4_8.isEnabled = false
        btn4_8.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
    }
}
