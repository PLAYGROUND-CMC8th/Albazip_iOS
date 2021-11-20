//
//  HomeManagerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerVC: BaseViewController{
    
    var isOpen = false
    
    @IBOutlet var mainView: UIView!
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
        tableView.register(UINib(nibName: "HomeManagerMainTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerMainTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerOpenTableViewCell")
        tableView.register(UINib(nibName: "HomeManagerCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerCommunityTableViewCell")
    }
    func setUI(){
        // 배경 색, 테이블 뷰 색 변경해줘야해서
        if isOpen{
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
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerQRCodeVC") as? HomeManagerQRCodeVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //알람 페이지로
    @IBAction func btnAlarm(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAlarmVC") as? HomeManagerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
extension HomeManagerVC: HomeCommunityViewCellDelegate{
    //각각의 소통창 페이지로
    func collectionView(collectionviewcell: HomeManagerCoummunityCollectionViewCell?, index: Int, didTappedInTableViewCell: HomeManagerCommunityTableViewCell) {
        
    }
    //소통창 페이지로
    func goCommunityPage() {
        
    }
    
    
}
// 테이블뷰 extension
extension HomeManagerVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if isOpen{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerOpenTableViewCell") as? HomeManagerOpenTableViewCell {
                    cell.selectionStyle = .none
                    //cell.bannerCellDelegate = self
                    //if let x = todayData{
                    //    cell.setCell(row: x.getBannerRes)
                    //}
                    cell.delegate = self
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerMainTableViewCell") as? HomeManagerMainTableViewCell {
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

extension HomeManagerVC: HomeManagerOpenDeleagate, HomeManagerAddWorkDelegate{
    //오늘 근무자 창
    func goTodayWorkerList() {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerWorkerTodayWorkerListVC") as? HomeManagerWorkerTodayWorkerListVC else {return}
       
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
    //업무 추가 알림창!
    func goAddWorkPage() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeManagerAddWorkVC") as? HomeManagerAddWorkVC {
            vc.modalPresentationStyle = .overFullScreen
            
            //modalBgView.alpha = 1
            //vc.delegate = self
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // 공동 업무 상세
    func goPublicWork() {
        print("goPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkVC") as? HomeManagerTodayWorkVC else {return}
        nextVC.segValue = 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    // 개인 업무 상세
    func goPrivateWork() {
        print("goPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerTodayWorkVC") as? HomeManagerTodayWorkVC else {return}
        nextVC.segValue = 1
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension HomeManagerVC: HomeManagerAddWorkSelectDelegate{
    // 공동업무 추가 페이지로
    func goAddPublicWork() {
        print("goAddPublicWork")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAddPublicWorkVC") as? HomeManagerAddPublicWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    // 개인 업무 추가 페이지로
    func goAddPrivateWork() {
        print("goAddPrivateWork()")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerAddPrivateWorkVC") as? HomeManagerAddPrivateWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
