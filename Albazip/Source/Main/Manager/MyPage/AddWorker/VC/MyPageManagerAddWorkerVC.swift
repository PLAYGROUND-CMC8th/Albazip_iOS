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
    
    //폼 요소 다 채워졌는지 확인
    var checkValue1 = false
    var checkValue2 = false
    var checkValue3 = true
    
    // data
    var rank = ""
    var title2 = ""
    var title3 = ""
    var workDay = [String]()
    var breakTime = ""
    var salary = "8720"
    
    var isWorkDaySetted = false{
        didSet{
            if isWorkDaySetted{
                tableView.beginUpdates()
                tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                tableView.endUpdates()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
    }
    //MARK:- View Setup
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        modalBgView.isHidden = true
        btnNext.isEnabled = false
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "MyPageManagerSelectInfo3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerSelectInfo3TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
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
        data.title = title3 + title2
        data.rank = rank
//        data.workDays = workDay
        
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
    
    @objc func goSelectWorkHourPage(_ sender: UIButton){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SelectWorkerHourVC") as? SelectWorkerHourVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
//MARK:- Table View Data Source

extension MyPageManagerAddWorkerVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.section {
        case 0:
            return 104
        
        case 1:
            return 50
            
        case 2:
            return 57
            
        default:
            
        return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 78
        }else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        // 섹션 title
        let sectionTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(hex: 0x000000)
        }
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(36)
            $0.height.equalTo(19)
        }
        
        switch section{
        case 0:
            sectionTitle.text = "포지션 선택하기"
        case 1:
            sectionTitle.text = "스케줄 입력하기"
        case 2:
            sectionTitle.text = "급여 입력하기"
        default:
            break
        }
        
        if section == 0{
            // 섹션 subTitle
            let sectionSubTitle = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                $0.textColor = UIColor(hex: 0xA3A3A3)
                $0.text = "포지션이 여러개라면, 메인 포지션을 선택해 주세요."
            }
            sectionView.addSubview(sectionSubTitle)
            
            sectionSubTitle.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(24)
                $0.top.equalTo(sectionTitle.snp.bottom).offset(6)
                $0.height.equalTo(17)
            }
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            
            return UITableViewCell()
        case 1:
            if indexPath.row == 0 {
                
            }else{
                let cell = UITableViewCell()
                
                let hourBtn = UIButton().then{
                    $0.setTitleColor(UIColor(hex: 0x6f6f6f), for: .normal)
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                    if isWorkDaySetted{
                        $0.setTitle("근무일 설정하기", for: .normal)
                    }else{
                        $0.setTitle("근무일 변경하기", for: .normal)
                    }
                    $0.layer.cornerRadius = 10
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor(hex: 0xededed).cgColor
                }
                cell.contentView.addSubview(hourBtn)
                hourBtn.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.trailing.leading.equalToSuperview().inset(36)
                }
                
                hourBtn.addTarget(self, action: #selector(goSelectWorkHourPage(_:)), for: .touchUpInside)
                
                return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
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

extension MyPageManagerAddWorkerVC:  MyPageManagerPayTypeModalDelegate{

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

