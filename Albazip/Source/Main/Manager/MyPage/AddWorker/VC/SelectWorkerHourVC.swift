//
//  SelectWorkerHourVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/04.
//

import UIKit
import SnapKit
import Then

class SelectWorkerHourVC: UIViewController{
    
    var workHourArr = [WorkHour]()
    var workDayTypes = [Bool]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextBtn: UIButton!
    let modalBgView = UIView()
    
    var isAllSameHour = false { // 모든 영업시간 일치 여부
        didSet{
            if isAllSameHour{
                tableView.reloadData()
            }else{
                tableView.beginUpdates()
                tableView.reloadSections(IndexSet(0...0), with: .none)
                tableView.endUpdates()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let workerInfo = MyPageManagerAddWorkerInfo.shared
        if let workHour = workerInfo.workSchedule{
            workHourArr = workHour
            workDayTypes = workerInfo.workDayTypes
        }else{
            initWorkHour()
        }
        checkValue()
        tableView.reloadData()
    }
    
    func setUI(){
        modalBgView.backgroundColor = .separator
        view.addSubview(modalBgView)
        modalBgView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        modalBgView.isHidden = true
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WorkHourTableViewCell.self, forCellReuseIdentifier: "WorkHourTableViewCell")
    }
    
    // 요일별 데이터 세팅
    func initWorkHour(){
        for i in 0...6{
            workHourArr.append(WorkHour(startTime: nil, endTime: nil, day: SysUtils.dayOfIndex(index: i)))
            workDayTypes.append(false)
        }
    }
    
    // 모든 요일 동일 버튼
    @objc func allSameBtnclicked(_ sender: UIButton){
        if isAllSameHour{
            isAllSameHour = false
            checkValue()
        }else{
            // 선택한 근무일이 없을 때
            if !workDayTypes.contains(true){
                presentBottomAlert(message: "시간을 설정할 근무일을 선택해주세요.")
                return
            }
            
            let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
            if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectAllStoreHourVC") as? RegisterSelectAllStoreHourVC {
                vc.modalPresentationStyle = .overFullScreen
                vc.delegate = self
                vc.whatHour = .workHour
                modalBgView.isHidden = false
                self.present(vc, animated: true, completion: nil)

            }
        }
    }
    
    @objc func setOpenHour(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen
            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatHour = .workHour
            vc.whenHour = .startTime
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)

        }
    }
    @objc func setCloseHour(_ sender: UIButton) {
        let newStoryboard = UIStoryboard(name: "RegisterManagerStoryboard", bundle: nil)
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "RegisterSelectTimeVC") as? RegisterSelectTimeVC {
            vc.modalPresentationStyle = .overFullScreen

            modalBgView.isHidden = false
            vc.timeDateModalDelegate = self
            vc.whatHour = .workHour
            vc.whenHour = .endTime
            vc.index = sender.tag
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func checkDayBtn(_ sender: UIButton) {
        if isAllSameHour{
            isAllSameHour = false
        }
        let index = sender.tag
        
        if (workDayTypes[index]){
            // 요일 선택 해제 시, 해당 요일 시간 초기화
            workHourArr[index].startTime = nil
            workHourArr[index].endTime = nil
        }
        workDayTypes[index] = !workDayTypes[index]
        
        checkValue()
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .fade)
        tableView.endUpdates()
    }
    
    func checkValue(){
        // 선택한 요일 다 입력했는지 검사
        for (index, value) in workHourArr.enumerated(){
            if (workDayTypes[index]) && ((value.startTime == nil) || (value.endTime == nil)){
                nextBtn.isEnabled = false
                nextBtn.setTitleColor(UIColor(hex: 0xADADAD), for: .normal)
                return
            }
        }
        
        if workDayTypes.contains(true){
            nextBtn.isEnabled = true
            nextBtn.setTitleColor(UIColor(hex: 0xFFB100), for: .normal)
        }else{
            nextBtn.isEnabled = false
            nextBtn.setTitleColor(UIColor(hex: 0xADADAD), for: .normal)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let workerInfo = MyPageManagerAddWorkerInfo.shared
        workerInfo.workSchedule = workHourArr
        workerInfo.workDayTypes = workDayTypes
        
        self.navigationController?.popViewController(animated: true)
    }
}

// 테이블뷰 extension
extension SelectWorkerHourVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 7
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ // 1. 매장 휴무일
            let cell = UITableViewCell()
            
            let checkBtn = UIButton().then{
                if isAllSameHour{
                    $0.setImage(UIImage(named: "checkCircleActive30Px"), for: .normal)
                }else{
                    $0.setImage(UIImage(named: "checkCircleInactive30Px"), for: .normal)
                }
            }
            
            let checkLabel = UILabel().then{
                $0.font = .systemFont(ofSize: 16, weight: .medium)
                $0.textColor = UIColor(hex: 0x343434)
                $0.text = "모든 근무시간이 같아요."
            }
            
            cell.contentView.addSubview(checkBtn)
            cell.contentView.addSubview(checkLabel)
            
            checkBtn.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(30)
                $0.leading.equalToSuperview().inset(24)
            }
            
            checkLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(checkBtn.snp.trailing).offset(6)
            }
            
            checkBtn.addTarget(self, action: #selector(allSameBtnclicked(_:)), for: .touchUpInside)
            
            cell.selectionStyle = .none
            
            return cell
        }else if indexPath.section == 1{ // 2. 추가된 영업 시간
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WorkHourTableViewCell") as? WorkHourTableViewCell {
                cell.selectionStyle = .none
                
                // 오픈 시간
                cell.storeHourView.openBtn.addTarget(self, action: #selector(setOpenHour(_:)), for: .touchUpInside)
                cell.storeHourView.openBtn.tag = indexPath.row
                
                // 마감 시간
                cell.storeHourView.closeBtn.addTarget(self, action: #selector(setCloseHour(_:)), for: .touchUpInside)
                cell.storeHourView.closeBtn.tag = indexPath.row
                
                // 요일 체크 버튼
                cell.checkBtn.tag = indexPath.row
                cell.checkBtn.addTarget(self, action: #selector(checkDayBtn(_:)), for: .touchUpInside)
                
                // data setting
                cell.storeHourView.whatHour = .workHour
                cell.setUp(workHour: self.workHourArr[indexPath.row], workDayType: self.workDayTypes[indexPath.row], index: indexPath.row)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 74
        }else if indexPath.section == 1{
            if workDayTypes[indexPath.row]{
                return 156
            }else{
                return 77
            }
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let middleView = UIView().then {
               $0.backgroundColor = UIColor(hex: 0xefefef)
            }
            return middleView
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 10
        }else{
            return 0.1
        }
    }
}

// 오픈, 마감 시간 delegate
extension SelectWorkerHourVC: TimeDateModalDelegate {
    
    func timeModalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }

    func openTimeTextFieldData(data: String, index: Int) {
        if isAllSameHour{
            isAllSameHour = false
        }
        
        workHourArr[index].startTime = data
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        tableView.endUpdates()
    }
    func endTimeTextFieldData(data: String, index: Int) {
        if isAllSameHour{
            isAllSameHour = false
        }
        
        workHourArr[index].endTime = data
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
        tableView.endUpdates()
    }
}

// 모든 요일 동일 delegate
extension SelectWorkerHourVC: AllStoreHourDelegate {
    func getAllTimeHour(workHour: WorkHour, isAllHour: Bool) {
        modalBgView.isHidden = true
        // 영업시간 세팅
        workHourArr = workHourArr.enumerated()
            .map { (index, element) -> WorkHour in
            if workDayTypes[index]{ // 선택된 요일이면 값 없데이트
                return WorkHour(startTime: workHour.startTime, endTime: workHour.endTime, day: SysUtils.dayOfIndex(index: index))
            }else{ // 선택안된 요일이면 값 그대로
                return element
            }
        }
        
        isAllSameHour = true
        checkValue()
    }
    
    func storeHourModalDismiss() {
        modalBgView.isHidden = true
        checkValue()
    }
}
