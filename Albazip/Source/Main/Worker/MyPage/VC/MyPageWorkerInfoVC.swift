//
//  MyPageWorkerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

protocol MyPageWorkerInfoTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}


class MyPageWorkerInfoVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var myPageWorkerInfoTableViewScrollDelegate: MyPageWorkerInfoTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    lazy var dataManager: MyPageWorkerMyInfoDatamanager = MyPageWorkerMyInfoDatamanager()
    //MARK:- Data Source
    var userInfo: MyPageWorkerMyInfoUserInfo?
    var workInfo: MyPageWorkerMyInfoWorkInfo?
    var joinDate: String?
    
    var numberOfCells: Int = 5
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        showIndicator()
        dataManager.getMyPageWorkerMyInfo(vc: self)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageWorkerMyInfoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageWorkerMyInfoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 473
    }
    

}
//MARK:- Table View Data Source

extension MyPageWorkerInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageWorkerMyInfoTableViewCell") as? MyPageWorkerMyInfoTableViewCell {
            
            cell.delegate = self
            if let data = userInfo{
                cell.numberLabel.text = data.phone!.insertPhone
                cell.yearLabel.text = "\(data.birthyear!)년생"
                if data.gender! == 0{
                    cell.sexLabel.text = "남자"
                }else{
                    cell.sexLabel.text = "여자"
                }
            }
            if let data = workInfo{
                cell.lateCountLabel.text = String(data.lateCount!)
                if data.totalTaskCount! != 0{
                    cell.clearRateLabel.text = String(data.completeTaskCount! / data.totalTaskCount! * 100)
                }else{
                    cell.clearRateLabel.text = "0"
                }
                
                cell.joinPublicLabel.text = String(data.coTaskCount!)
                
            }
            if let data = joinDate{
                cell.joinDatelabel.text = data.insertDate
            }
            
            print(indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 473
    }
    
    
}

//MARK:- Scroll View Actions

extension MyPageWorkerInfoVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageWorkerInfoTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageWorkerInfoTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageWorkerInfoTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageWorkerInfoTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageWorkerInfoTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}


extension MyPageWorkerInfoVC: MyPageWorkerMyInfoDelegate {
  
    
    
    func goCommuteRecordVC(lateCount:String){
        print("출퇴근 기록 페이지로..")
        let storyboard = UIStoryboard(name: "MyPageWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MyPageDetailCommuteRecordVC") as? MyPageDetailCommuteRecordVC else {return}
        nextVC.lateCount = lateCount
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func goPublicWorkVC(){
        print("공동업무 페이지로..")
        let storyboard = UIStoryboard(name: "MyPageWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MyPageDetailPublicWorkVC") as? MyPageDetailPublicWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func goClearWorkVC(){
        print("완료 업무 페이지로..")
        let storyboard = UIStoryboard(name: "MyPageWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MyPageDetailClearWorkVC") as? MyPageDetailClearWorkVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func goLeaveWorkVC(){
        print("퇴사 알림창..")
        let storyboard = UIStoryboard(name: "MyPageWorkerStoryboard", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MyPageDetailStopWorkVC") as? MyPageDetailStopWorkVC {
            vc.modalPresentationStyle = .overFullScreen
            //myPageManagerWorkerPositionAlertDelegate?.modalShow()
            
        self.present(vc, animated: true, completion: nil)
        }
    }
}
extension MyPageWorkerInfoVC {
    func didSuccessMyPageWorkerMyInfo(result: MyPageWorkerMyInfoResponse) {
        
        userInfo = result.data?.userInfo
        workInfo = result.data?.workInfo
        joinDate = (result.data?.joinDate!)!
        print(result.message!)
        
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageWorkerMyInfo(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

