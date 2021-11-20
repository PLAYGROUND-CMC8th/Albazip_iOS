//
//  HomeWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerVC: BaseViewController{
    
    var isWork = true
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var storeNameView: UIStackView!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeWorkerMainTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerMainTableViewCell")
        tableView.register(UINib(nibName: "HomeWorkerWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerWorkTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerCommunityTableViewCell")
    }
    func setUI(){
        // 배경 색, 테이블 뷰 색 변경해줘야해서
        if isWork{
            tableView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
        }else{
            tableView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
            mainView.backgroundColor = #colorLiteral(red: 0.9991409183, green: 0.9350905418, blue: 0.7344018817, alpha: 1)
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    //큐알 페이지로
    @IBAction func btnQRCode(_ sender: Any) {
        if let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerQRCodeVC") as? HomeWorkerQRCodeVC {
            nextVC.modalPresentationStyle = .overFullScreen
            
        self.present(nextVC, animated: true, completion: nil)
        }
    }
    //알람 페이지로
    @IBAction func btnAlarm(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerAlarmVC") as? HomeWorkerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
// 테이블뷰 extension
extension HomeWorkerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if isWork{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerWorkTableViewCell") as? HomeWorkerWorkTableViewCell {
                    cell.selectionStyle = .none
                    //cell.bannerCellDelegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    cell.delegate = self
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerMainTableViewCell") as? HomeWorkerMainTableViewCell {
                    cell.selectionStyle = .none
                    //cell.bannerCellDelegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    cell.delegate = self
                    return cell
                }
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerCommunityTableViewCell") as? HomeManagerCommunityTableViewCell {
                //cell.eventCellDelegate = self
                //cell.setCell(event: eventArray, eventText: eventTextArray)
                cell.selectionStyle = .none
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 480
        case 1:
            return 242
       
        default:
            return 0
        }
    }
}
extension HomeWorkerVC: HomeWorkerAddWorkDelegate{
    // 완료 업무 페이지 or QR 페이지
    func goNextPage() {
        if let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerQRCodeVC") as? HomeWorkerQRCodeVC {
            nextVC.modalPresentationStyle = .overFullScreen
            
        self.present(nextVC, animated: true, completion: nil)
        }
    }
}
extension HomeWorkerVC: HomeWorkerWorkDeleagate{
    //공동 업무 페이지
    func goPublicWork() {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerTodayWorkVC") as? HomeWorkerTodayWorkVC else {return}
        nextVC.segValue = 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //개인 업무 페이지
    func goPrivateWork() {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeWorkerTodayWorkVC") as? HomeWorkerTodayWorkVC else {return}
        nextVC.segValue = 1
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
