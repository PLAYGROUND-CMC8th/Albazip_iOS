//
//  MyPageManagerAddWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import Foundation
import UIKit

class MyPageManagerAddWorkerVC: UIViewController{
    
    
    @IBOutlet var modalBgView: UIView!
    
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tableView: UITableView!
    
    // 시간 변수
    var startTime = ""
    var endTime = ""
    var payTime = "시급"
    var hour = "0시간"
    // 테이블뷰 접었다 펴기
    var isDateSelected = false
    
    //폼 요소 다 채워졌는지 확인
    var checkValue1 = false
    var checkValue2 = false
    var checkValue3 = true
    
    // data
    var rank = ""
    var title2 = ""
    var workDay = [String]()
    var breakTime = ""
    var salary = "8720"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
    }
    //MARK:- View Setup
    func setUI(){
        //self.tabBarController?.tabBar.isHidden = true
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
        btnNext.isEnabled = false
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo1TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo3TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoHeightTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoHeightTableViewCell")
        //MyPageManagerNoHeightTableViewCell
        self.tableView.estimatedRowHeight = 1
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        let data = MyPageManagerAddWorkerInfo.shared
        data.startTime = startTime.replace(target: ":", with: "")
        data.endTime = endTime.replace(target: ":", with: "")
        data.salaryType = payTime
        data.salary = salary
        data.breakTime = breakTime
        data.title = title2
        data.rank = rank
        data.workDays = workDay
        
        print("data:\(data.rank) \(data.title) \(data.startTime) \(data.endTime) \(data.workDays) \(data.breakTime) \(data.salary) \(data.salaryType)")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageManagerWorkListVC") as? MyPageManagerWorkListVC else {return}
                self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //모든 값이 입력되었는지 확인
    func checkContent(){
        if checkValue1, checkValue2, checkValue3, startTime != "", endTime != ""{
            
            btnNext.isEnabled = true
            btnNext.setTitleColor(#colorLiteral(red: 0.9961670041, green: 0.7674626112, blue: 0, alpha: 1), for: .normal)
            
        }else{
            btnNext.isEnabled = false
            btnNext.setTitleColor(#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1), for: .normal)
        }
    }
    
    //시간차 구하기
    func calculateTime(){
        if startTime != "", endTime != "" {
            let startTime = startTime.components(separatedBy: ":")
            let endTime = endTime.components(separatedBy: ":")
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
            
            self.hour  = "\(hour)시간\(minute)분"
        }
    }

}
//MARK:- Table View Data Source

extension MyPageManagerAddWorkerVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo1TableViewCell") as? MyPageManagerSelectInfo1TableViewCell {
                cell.selectionStyle = .none
                cell.myPageManagerSelectInfo1Delegate = self
                return cell
            }
        case 1:
            if isDateSelected{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo2TableViewCell") as? MyPageManagerSelectInfo2TableViewCell {
                    cell.selectionStyle = .none
                    cell.myPageManagerTimeDateModalDelegate = self
                    if startTime != ""{
                        cell.startButton.setTitle(startTime, for: .normal)
                        cell.startButton.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
                    }
                    if endTime != ""{
                        cell.endButton.setTitle(endTime, for: .normal)
                        cell.endButton.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
                    }
                    cell.hourLabel.text = self.hour
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoHeightTableViewCell") as? MyPageManagerNoHeightTableViewCell {
                    cell.selectionStyle = .none
                    
                    print(indexPath.row)
                    return cell
                }
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerSelectInfo3TableViewCell") as? MyPageManagerSelectInfo3TableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                cell.myPageManagerPayTypeModalDelegate = self
                if payTime != ""{
                    cell.payTypeLabel.text = payTime
                    
                }
                salary = cell.moneyTextField.text!
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 397
        
        case 1:
            if isDateSelected{
                return 269
            }else{
                return 1
            }
        case 2:
            return 208
        default:
            
        return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
}
extension MyPageManagerAddWorkerVC: TimeDateModalDelegate {
    func timeModalDismiss() {
        modalBgView.isHidden = true
        //checkValue()
    }

    func openTimeTextFieldData(data: String) {
        startTime = data
        tableView.reloadData()
        calculateTime()
    }

    func endTimeTextFieldData(data: String) {
        endTime = data
        tableView.reloadData()
        calculateTime()
    }
}

extension MyPageManagerAddWorkerVC: SelectPayTypeDelegate {
    func modalDismiss(){
        modalBgView.isHidden = true
    }
    func textFieldData(data: String){
        payTime = data
        tableView.reloadData()
    }

    
}

extension MyPageManagerAddWorkerVC: MyPageManagerTimeDateModalDelegate, MyPageManagerPayTypeModalDelegate, MyPageManagerSelectInfo1Delegate{
    
    func setRank(text: String) {
        rank = text
        print("rank:\(rank)")
    }
    
    func setTitle(text: String) {
        title2 = text
        print("title:\(title2)")
    }
    func setBreaktime(text: String) {
        breakTime = text
        print("breakTime:\(breakTime)")
    }
    func addDay(text: String) {
        workDay.append(text)
        print("workday:\(workDay)")
    }
    
    func deleteDay(text: String) {
        if let firstIndex = workDay.firstIndex(of: text) {
            workDay.remove(at: firstIndex)
        }
        print("workday:\(workDay)")
    }
    
    
    func checkValue1(value: Bool) {
        print(value)
        checkValue1 = value
        checkContent()
    }
    func checkValue2(value: Bool) {
        print(value)
        checkValue2 = value
        checkContent()
    }
    
    func checkValue3(text: String) {
        print("salary: "+text)
        salary = text
        if text != ""{
            checkValue3 = true
        }else{
            checkValue3 = false
        }
        checkContent()
    }
    func presentAlert(text: String) {
        showMessage(message: text, controller: self)
    }
    
    func openView() {
        isDateSelected = true
        tableView.reloadData()
    }
    
    func closeView() {
        isDateSelected = false
        tableView.reloadData()
    }
    
    //타임 피커 페이지로..
    func goSelectTimeDate(index: Int) {
        print("goSelectTimeDate")
        let storyboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
                    modalBgView.isHidden = false
                    vc.timeDateModalDelegate = self
                    vc.whatDate = index
                    if index == 0{
                        vc.titletext = "출근 시간"
                    }else{
                        vc.titletext = "퇴근 시간"
                    }
                    self.present(vc, animated: true, completion: nil)
                    
                }
    }
    
    //급여 계산 기준 선택 페이지로
    func goSelectPayType() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageManagerSelectPayTypeVC") as? MyPageManagerSelectPayTypeVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
                    modalBgView.isHidden = false
                    vc.selectPayTypeDelegate = self
                    
                    self.present(vc, animated: true, completion: nil)
                    
        }
    }
    
    
}
