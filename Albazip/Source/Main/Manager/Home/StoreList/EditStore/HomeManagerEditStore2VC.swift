//
//  HomeManagerEditStore2VC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeManagerEditStore2VC: UIViewController{
    
    @IBOutlet var btnNoBreak: UIButton!
    @IBOutlet var btnMon: UIButton!
    @IBOutlet var btnTue: UIButton!
    @IBOutlet var btnWed: UIButton!
    @IBOutlet var btnThu: UIButton!
    @IBOutlet var btnFri: UIButton!
    @IBOutlet var btnSat: UIButton!
    @IBOutlet var btnSun: UIButton!
    @IBOutlet var btnBreak: UIButton!
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var startTextField: UITextField!
    @IBOutlet var endTextField: UITextField!
    
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var salaryTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    
    var startTime = ""
    var endTime = ""
    var salary = ""
    
    var holiday = [String]()
    var managerId = -1
    // Datamanager
    lazy var dataManager: HomeManagerEditStoreDatamanager = HomeManagerEditStoreDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setBeforeData()
    }
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        salaryTextField.addRightPadding()
        modalBgView.isHidden = true
        salaryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        startTextField.addLeftPadding()
        endTextField.addLeftPadding()
        startTextField.addTarget(self, action: #selector(startTimeTextFieldDidChange(_:)), for: .touchDown)
        endTextField.addTarget(self, action: #selector(endTimeTextFieldDidChange(_:)), for: .touchDown)
        salaryTextField.attributedPlaceholder = NSAttributedString(string: "1 - 31    ", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        startTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 30)!])
        endTextField.attributedPlaceholder = NSAttributedString(string: "00:00", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 30)!])
    }
    func setBeforeData(){
        startTextField.text = startTime
        endTextField.text = endTime
        salaryTextField.text = salary
        calculateTime()
        if holiday.contains("연중무휴"){
            btnNoBreak.isSelected = true
            disableBtn(btn: btnMon)
            disableBtn(btn: btnTue)
            disableBtn(btn: btnWed)
            disableBtn(btn: btnThu)
            disableBtn(btn: btnFri)
            disableBtn(btn: btnSat)
            disableBtn(btn: btnSun)
            disableBtn(btn: btnBreak)
            selectedBtn(btn: btnNoBreak)
        }else{
            disableBtn(btn: btnNoBreak)
            if holiday.contains("월"){
                btnMon.isSelected = true
                selectedBtn(btn: btnMon)
                //selectedBtn(btn: btnMon)
            }
            if holiday.contains("화"){
                btnTue.isSelected = true
                selectedBtn(btn: btnTue)
            }
            if holiday.contains("수"){
                btnWed.isSelected = true
                selectedBtn(btn: btnWed)
            }
            if holiday.contains("목"){
                btnThu.isSelected = true
                selectedBtn(btn: btnThu)
            }
            if holiday.contains("금"){
                btnFri.isSelected = true
                selectedBtn(btn: btnFri)
            }
            if holiday.contains("토"){
                btnSat.isSelected = true
                selectedBtn(btn: btnSat)
            }
            if holiday.contains("일"){
                btnSun.isSelected = true
                selectedBtn(btn: btnSun)
            }
            if holiday.contains("공휴일"){
                btnBreak.isSelected = true
                selectedBtn(btn: btnBreak)
            }
        }
    }
    
    @IBAction func btnNoBreak(_ sender: Any) {
        btnNoBreak.isSelected.toggle()
        if(btnNoBreak.isSelected){
            print("1")
            disableBtn(btn: btnMon)
            disableBtn(btn: btnTue)
            disableBtn(btn: btnWed)
            disableBtn(btn: btnThu)
            disableBtn(btn: btnFri)
            disableBtn(btn: btnSat)
            disableBtn(btn: btnSun)
            disableBtn(btn: btnBreak)
            selectedBtn(btn: btnNoBreak)
        }else{
            print("2")
            enableBtn(btn: btnMon)
            enableBtn(btn: btnTue)
            enableBtn(btn: btnWed)
            enableBtn(btn: btnThu)
            enableBtn(btn: btnFri)
            enableBtn(btn: btnSat)
            enableBtn(btn: btnSun)
            enableBtn(btn: btnBreak)
            enableBtn(btn: btnNoBreak)
        }
        checkValue()
    }
    @IBAction func btnMon(_ sender: Any) {
        btnMon.isSelected.toggle()
        if(btnMon.isSelected){
            selectedBtn(btn: btnMon)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnMon)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnTue(_ sender: Any) {
        btnTue.isSelected.toggle()
        if(btnTue.isSelected){
            selectedBtn(btn: btnTue)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnTue)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnWed(_ sender: Any) {
        btnWed.isSelected.toggle()
        if(btnWed.isSelected){
            selectedBtn(btn: btnWed)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnWed)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnThu(_ sender: Any) {
        btnThu.isSelected.toggle()
        if(btnThu.isSelected){
            selectedBtn(btn: btnThu)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnThu)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnFri(_ sender: Any) {
        btnFri.isSelected.toggle()
        if(btnFri.isSelected){
            selectedBtn(btn: btnFri)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnFri)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnSat(_ sender: Any) {
        btnSat.isSelected.toggle()
        if(btnSat.isSelected){
            selectedBtn(btn: btnSat)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnSat)
            checkBtn()
        }
        checkValue()
    }
    
    @IBAction func btnSun(_ sender: Any) {
        btnSun.isSelected.toggle()
        if(btnSun.isSelected){
            selectedBtn(btn: btnSun)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnSun)
            checkBtn()
        }
        checkValue()
    }
    @IBAction func btnBreak(_ sender: Any) {
        btnBreak.isSelected.toggle()
        if(btnBreak.isSelected){
            selectedBtn(btn: btnBreak)
            disableBtn(btn: btnNoBreak)
        }else{
            enableBtn(btn: btnBreak)
            checkBtn()
        }
        checkValue()
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectSalaryDateVC") as? RegisterSelectSalaryDateVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.isHidden = false
            vc.salaryModalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
            
    }
    
    @objc func startTimeTextFieldDidChange(_ textField:UITextField) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 0
            vc.titletext = "매장 오픈 시간"
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    @objc func endTimeTextFieldDidChange(_ textField:UITextField) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatDate = 1
            vc.titletext = "매장 마감 시간"
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    func selectedBtn(btn: UIButton){
        btn.isEnabled = true
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
        btn.isSelected = true
    }
    
    func enableBtn(btn: UIButton){
        btn.isEnabled = true
        btn.backgroundColor = .none
        btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
        btn.isSelected = false
    }
    
    func disableBtn(btn: UIButton){
        btn.isEnabled = false
        btn.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
        btn.isSelected = false
    }
    
    func checkBtn(){
        if !btnMon.isSelected, !btnTue.isSelected, !btnWed.isSelected, !btnThu.isSelected, !btnFri.isSelected, !btnSat.isSelected, !btnSun.isSelected, !btnBreak.isSelected{
            enableBtn(btn: btnNoBreak)
        }
    }
    //모든 값을 다 입력했는지 검사
    func checkValue(){
        print(startTextField.text!)
        
        if startTextField.text != "" && endTextField.text != "" && salaryTextField.text != ""{
            if btnNoBreak.isSelected{
                //연중무휴 체크
                btnNext.isEnabled = true
                //btnNext.backgroundColor = .mainYellow
                btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
            }else if !btnMon.isSelected, !btnTue.isSelected, !btnWed.isSelected, !btnThu.isSelected, !btnFri.isSelected, !btnSat.isSelected, !btnSun.isSelected, !btnBreak.isSelected{
                // 아무것도 체크 안됨
                btnNext.isEnabled = false
                //btnNext.backgroundColor = .semiYellow
                btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
            }else{
                //버튼중에 하나는 선택되어있음
                btnNext.isEnabled = true
                //btnNext.backgroundColor = .mainYellow
                btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
            }
        }else{
            btnNext.isEnabled = false
            //btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    
    //시간차 구하기
    func calculateTime(){
        if startTextField.text!.count > 0, endTextField.text!.count > 0{
            let startTime = startTextField.text!.components(separatedBy: ":")
            let endTime = endTextField.text!.components(separatedBy: ":")
            var startTotal = 0
            var endTotal = 0
            var hour = 0
            var minute = 0
            
            //마감시간이 오픈시간 값보다 작을 때 마감시간에 24더하고 빼주기
            if Int(startTime[0])!>Int(endTime[0])!{
                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
            }else if Int(startTime[0])!==Int(endTime[0])! , Int(startTime[1])!>Int(endTime[1])!{
                endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
            }
            //오픈 시간보다 마감시간이 더 빠를때!
            else{
                endTotal = Int(endTime[0])! * 60 + Int(endTime[1])!
            }
            startTotal = Int(startTime[0])! * 60 + Int(startTime[1])!
            
            let diffTime = endTotal - startTotal
            hour = diffTime/60
            minute = diffTime%60
            
            hourLabel.text = "\(hour)시간\(minute)분"
        }
    }
    
    //휴일 정보를 배열에 저장
    func getHoliday(){
        //연중 무휴가 아닐때 배열에 추가
        if !btnNoBreak.isSelected{
            if btnMon.isSelected{
                holiday.append("월")
            }
            if btnTue.isSelected{
                holiday.append("화")
            }
            if btnWed.isSelected{
                holiday.append("수")
            }
            if btnThu.isSelected{
                holiday.append("목")
            }
            if btnFri.isSelected{
                holiday.append("금")
            }
            if btnSat.isSelected{
                holiday.append("토")
            }
            if btnSun.isSelected{
                holiday.append("일")
            }
            if btnBreak.isSelected{
                holiday.append("공휴일")
            }
        }else{
            holiday.append("연중무휴")
        }
        print(holiday)
    }
    @IBAction func btnNext(_ sender: Any) {
        // 몇시간 몇분 시간 계산
        holiday.removeAll()
        // 휴무일 정보 불러오기
        getHoliday()
        
        // 기존 입력 값 불러오기
        let data = RegisterManagerInfo.shared
        
        //시간에서 : 문자 제거
        let removeStartTime = startTextField.text!.replace(target: ":", with: "")
        let removeEndTime = endTextField.text!.replace(target: ":", with: "")
        
        //로그인화면에서 포지션 선택으로 온것인지 관리자 가입에서 온것인지 잘 판단해야할듯, => 둘다 토큰을 Userdault말고 RegisterBasicInfo에 저장하자!
        
        // api resquest 데이터
        
        let input = HomeManagerEditStoreRequest(name: data.name!, type: data.type!, address: data.address!, startTime: removeStartTime, endTime: removeEndTime, holiday: holiday, payday: salaryTextField.text!)
        print(input)
        
        // api 통신
        showIndicator()
        dataManager.postEditStore(managerId: managerId, input, delegate: self)
        
        
        //휴무일 정보 reset
        holiday.removeAll()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension HomeManagerEditStore2VC: SalaryModalDelegate {
    
    func modalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }
    
    func textFieldData(data: String) {
        salaryTextField.text = data
        
    }
}

extension HomeManagerEditStore2VC: TimeDateModalDelegate {
    
    func timeModalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }
    
    func openTimeTextFieldData(data: String) {
        startTextField.text = data
        calculateTime()
    }
    func endTimeTextFieldData(data: String) {
        endTextField.text = data
        calculateTime()
    }
}

extension HomeManagerEditStore2VC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(textField == startTextField || textField == endTextField){
                let newLength = (textField.text?.count)! + string.count - range.length
                    return !(newLength > 4)
            }
            
            return true
        }
}

extension HomeManagerEditStore2VC {
    func didSuccessEditStore(result: HomeManagerEditStoreReponse) {
        print(result.message)
        
        dismissIndicator()
        backTwo()
    }
    
    func failedToEditStore(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: false)
    }
}
