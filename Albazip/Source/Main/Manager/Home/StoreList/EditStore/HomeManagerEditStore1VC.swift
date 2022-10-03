//
//  HomeManagerEditStore1VC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeManagerEditStore1VC:UIViewController{
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var storeNameTextField: UITextField!
    @IBOutlet var storeTypeTextField: UITextField!
    @IBOutlet var storeLocationTextField: UITextField!
    @IBOutlet var storeLocationDetailTextField: UITextField!
    
    @IBOutlet var btnNext: UIButton!
    var storeName = ""
    var storeLocation = ""
    var managerId = -1
    var selectedType = true
    // Datamanager
    lazy var dataManager: HomeManagerEditStoreBeforeDatamanager = HomeManagerEditStoreBeforeDatamanager()
    var storeData: HomeManagerEditStoreBeforeData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        showIndicator()
        dataManager.getHomeManagerEditStoreBefore(managerId: managerId, vc: self)
    }
    func setUI() {
        storeNameTextField.addLeftPadding()
        storeTypeTextField.addLeftPadding()
        storeLocationTextField.addLeftPadding()
        storeLocationDetailTextField.addLeftPadding()
        self.dismissKeyboardWhenTappedAround()
        storeNameTextField.delegate = self
        storeLocationTextField.delegate = self
        storeLocationDetailTextField.delegate = self
        storeTypeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .touchDown)
        modalBgView.alpha = 0.0
        storeNameTextField.attributedPlaceholder = NSAttributedString(string: "매장명과 지점 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        storeTypeTextField.attributedPlaceholder = NSAttributedString(string: "업종 선택", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        storeLocationTextField.attributedPlaceholder = NSAttributedString(string: "도로명이나 지번주소 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        storeLocationDetailTextField.attributedPlaceholder = NSAttributedString(string: "상세주소 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
      
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectStoreTypeVC") as? RegisterSelectStoreTypeVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            vc.modalDelegate = self
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    func checkTextField(){
        if storeNameTextField.text!.count > 0 , storeLocationTextField.text!.count > 0, storeLocationDetailTextField.text!.count > 0, selectedType{
            
            btnNext.isEnabled = true
            //btnNext.backgroundColor = .mainYellow
            btnNext.setTitleColor(#colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1), for: .normal)
        }else{
            btnNext.isEnabled = false
            //btnNext.backgroundColor = .semiYellow
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        let registerManagerInfo = RegisterManagerInfo.shared
        registerManagerInfo.name = storeNameTextField.text!
        registerManagerInfo.type = storeTypeTextField.text!
        registerManagerInfo.address = storeLocationTextField.text! + " " + storeLocationDetailTextField.text!
       
        let storyboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "RegisterMoreInfoVC") as? RegisterMoreInfoVC else {return}
        nextVC.writeType = .edit
        nextVC.salaryDate = storeData?.payday ?? ""
        nextVC.managerId = self.managerId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension HomeManagerEditStore1VC: UITextFieldDelegate{
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        if(textField == storeNameTextField){
            storeNameTextField.borderColor = .mainYellow
            storeLocationTextField.borderColor = .lightGray
            storeLocationDetailTextField.borderColor = .lightGray
        }else if(textField == storeLocationTextField){
            storeNameTextField.borderColor = .lightGray
            storeLocationTextField.borderColor = .mainYellow
            storeLocationDetailTextField.borderColor = .lightGray
        }else if(textField == storeLocationDetailTextField){
            storeNameTextField.borderColor = .lightGray
            storeLocationTextField.borderColor = .lightGray
            storeLocationDetailTextField.borderColor = .mainYellow
        }
        //checkTextField()
        
        return true
    }
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderColor = .lightGray
        checkTextField()
        print("텍스트 필드의 편집이 종료됩니다.")
    }
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다.")
        checkTextField()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        checkTextField()
        return true
    }
}

extension HomeManagerEditStore1VC: ModalDelegate {
    
    func modalDismiss() {
        modalBgView.alpha = 0.0
    }
    
    func textFieldData(data: String) {
        storeTypeTextField.text = data
        selectedType = true
        checkTextField()
    }
}
extension HomeManagerEditStore1VC {
    func didSuccessHomeManagerEditStore(result: HomeManagerEditStoreBeforeResponse) {
        guard let data = result.data else{ return}
        storeData = data
        storeNameTextField.text = data.name!
        storeTypeTextField.text = data.type!
        storeLocationTextField.text = data.address!
        
        // 영업 시간
        var workHour = [WorkHour]()
        var storeHourType = [StoreHourType]()
        
        let registerManagerInfo = RegisterManagerInfo.shared
        
        for openSchedule in data.openSchedule{
            var appended = false
            for holiday in data.holiday ?? [String](){
                if holiday == openSchedule.day{ // 휴무일
                    workHour.append(WorkHour(startTime: nil, endTime: nil, day: openSchedule.day))
                    storeHourType.append(.hoilday)
                    appended = true
                    break
                }
            }
            if !appended{
                workHour.append(WorkHour(startTime: openSchedule.startTime?.insertTime, endTime: openSchedule.endTime?.insertTime, day: openSchedule.day))
                if openSchedule.startTime == openSchedule.endTime{
                    storeHourType.append(.allDay) // 24시간 영업
                }else{
                    storeHourType.append(.normal) // default
                }
            }
        }
        registerManagerInfo.hoilday = Set(data.holiday ?? [String]())
        registerManagerInfo.workHour = workHour
        registerManagerInfo.storeHourType = storeHourType
        
        dismissIndicator()
    }
    
    func failedToRequestHomeManagerEditStore(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
