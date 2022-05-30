//
//  RegisterStoreHourVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/05/30.
//

import Foundation
import UIKit
import Then
import SnapKit

class RegisterStoreHourVC: UIViewController, StoreClosedDayDelegate{
    
    @IBOutlet var tableView: UITableView!
    // 버튼 선택 정보 저장
    var btnArray = [0, 0, 0, 0, 0, 0, 0, 0]
    // 순서) 연중 무휴, 월-금, 휴무일
    // enable:0, selected:1, disabled: 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setUI(){
    }
    @IBAction func btnNext(_ sender: Any) {

    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "StoreHourTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "StoreHourTableViewCell")
    }
    
    func btnDayClicked(index: Int) {
        switch (index){
        case 0:
            if btnArray[index] == 0{
                btnArray[index] = 1
                for i in 1...7{
                    btnArray[i] = 2
                }
            }else if btnArray[index] == 1{
                btnArray[index] = 0
                for i in 1...7{
                    btnArray[i] = 0
                }
            }
            break
            
        default:
            if btnArray[index] == 0{
                btnArray[index] = 1
                btnArray[0] = 2
            }else if btnArray[index] == 1{
                btnArray[index] = 0
                if !btnArray.contains(1){
                    btnArray[0] = 0
                }
            }
            break
        }
//        checkValue()
        tableView.reloadData()
    }
}
// 테이블뷰 extension
extension RegisterStoreHourVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 51
        }else{
            return 61
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView().then{
            $0.backgroundColor = .white
        }
        let sectionTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            $0.textColor = UIColor(hex: 0x6f6f6f)
        }
        
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(36)
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(19)
        }
        
        if section == 0{
            sectionTitle.text = "영업시간"
        }else {
            sectionTitle.text = "추가된 영업시간"
        }
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ // 1. 매장 휴무일
            if indexPath.row == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreHourTableViewCell") as? StoreHourTableViewCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.setUp(btnArray: self.btnArray)
                    return cell
                }
            }else if indexPath.row == 1{
                
            }else if indexPath.row == 2{
                
            }
        }else if indexPath.section == 1{ // 2. 추가된 영업 시간
                          
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 124
        }else if indexPath.section == 1{
            return 19
        }else{
            return 45
        }
    }
}
