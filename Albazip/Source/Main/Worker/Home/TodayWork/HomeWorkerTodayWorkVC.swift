//
//  HomeWorkerTodayWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerTodayWorkVC: UIViewController{
    var isNoNonCompleteData = true
    var isNoCompleteData = true
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    // 임시 데이터
    var nonCompleteTaskData: [MyPageDetailClearWorkDayNonCompleteTaskData]?
    var completeTaskData: [MyPageDetailClearWorkDayCompleteTaskData]?
    
    
    var segValue = 0 // 0이면 공동업무, 1이면 개인업무!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(segValue)
        setUI()
        setupTableView()
    }
    func setUI() {
        
        segment.cornerRadius = segment.bounds.height / 2
        let attributes = [
            NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes , for: .selected)
        
        let attributes2 = [
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6430723071, green: 0.6431827545, blue: 0.6430577636, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes2 , for: .normal)
        /*
        //corner radius
        let cornerRadius = segment.bounds.height / 2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        segment.clipsToBounds = true
        segment.layer.cornerRadius = cornerRadius
        segment.layer.maskedCorners = maskedCorners*/
        segment.selectedSegmentIndex = segValue
        
    }
    func setupTableView() {
        
//MyPageDetailClearWorkNoCompleteTableViewCell
        
        //테이블뷰 헤더 등록
        // Register the custom header view.
        //미완료 헤더
           tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
               forHeaderFooterViewReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")
        //완료 헤더
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkCompleteHeaderTableViewCell", bundle: nil),
            forHeaderFooterViewReuseIdentifier: "HomeWorkerPublicWorkCompleteHeaderTableViewCell")
        //HomeWorkerPublicWorkCompleteHeaderTableViewCell
        
        //미완료 82
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkNoCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerPublicWorkNoCompleteTableViewCell")
        //완료 82
        tableView.register(UINib(nibName: "HomeWorkerPublicWorkCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerPublicWorkCompleteTableViewCell")
        /*
        //미완료, 완료 헤더 50
        tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")*/
        //모두 완료: 100
        tableView.register(UINib(nibName: "MyPageDetailAllClearWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailAllClearWorkTableViewCell")
        
        //미완료, 완료 중간 구분자 43
        tableView.register(UINib(nibName: "MyPageDetailClearWorkMiddleTableViewCell", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "MyPageDetailClearWorkMiddleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension HomeWorkerTodayWorkVC: UITableViewDataSource,UITableViewDelegate {

    //섹션 헤더 개수
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //섹션 헤더 셀 지정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let  headerCell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as! MyPageDetailClearWorkNoCompleteTableViewCell
        let headerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkNoCompleteTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkNoCompleteTableViewCell
        
        let headerCell2 = Bundle.main.loadNibNamed("HomeWorkerPublicWorkCompleteHeaderTableViewCell", owner: self, options: nil)?.first as! HomeWorkerPublicWorkCompleteHeaderTableViewCell
        switch (section) {
        case 0:
            headerCell.titleLabel.text = "미완료"
            /*
            if let x = nonCompleteTaskData{
                headerCell.countLabel.text = String(x.count)
            }*/
            return headerCell
        case 1:
            
            /*
            if let x = completeTaskData{
                headerCell.countLabel.text = String(x.count)
            }*/
            return headerCell2
          //return sectionHeaderView
        default:
            headerCell.titleLabel.text = "Other";
        }
        print("헤더헤더")
        return headerCell
    }
    //섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isNoNonCompleteData{
                   return 1
            }else{
                /*
                if let x = nonCompleteTaskData{
                    return x.count
                }*/
            }
        }else if section == 1 {
            if isNoCompleteData{
                   return 1
            }else{
                /*
                if let x = completeTaskData{
                    return x.count
                }*/
            }
        }
        return 0
    }
    //셀의 값
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if isNoNonCompleteData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.titleLabel.text = "업무를 모두 완료했어요!"
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkTableViewCell") as? MyPageDetailNoClearWorkTableViewCell {
                    cell.selectionStyle = .none
                    /*
                    if let data = nonCompleteTaskData{
                        cell.titlelLabel.text = data[indexPath.row].title!
                        cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                        
                    }*/
                    print(indexPath.row)
                    return cell
                }
            }
        }else if indexPath.section == 1{
            if isNoCompleteData{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailAllClearWorkTableViewCell") as? MyPageDetailAllClearWorkTableViewCell {
                    cell.titleLabel.text = "완료된 업무가 없어요."
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                    cell.selectionStyle = .none
                    /*
                    if let data = completeTaskData{
                        cell.titleLabel.text = data[indexPath.row].title!
                        cell.subLabel.text = "완료  \(data[indexPath.row].complete_date!.substring(from: 11, to: 16))"
                        
                    }*/
                    print(indexPath.row)
                    return cell
                }
            }
        }else{
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    //푸터
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = Bundle.main.loadNibNamed("MyPageDetailClearWorkMiddleTableViewCell", owner: self, options: nil)?.first as! MyPageDetailClearWorkMiddleTableViewCell
        // 마지막 section은 footer 미표출

        if section == 0{
            return footerCell
        }else{
            
            return nil
        }
        
    }
    
    //푸터 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // footer 영역 크기 = 12 (마지막 section의 footer 크기는 0)
        if section == 0{
            return 43
        }
        return 0
    }
    // Select Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("\(indexPath.section): \(indexPath.row)")
    }
}
