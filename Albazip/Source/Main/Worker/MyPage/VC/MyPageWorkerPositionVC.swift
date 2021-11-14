//
//  MyPageWorkerPositionVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

protocol MyPageWorkerPositionTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MyPageWorkerPositionVC: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    //MARK:- Scroll Delegate
    
    weak var myPageWorkerPositionTableViewScrollDelegate: MyPageWorkerPositionTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    var positionInfo: MyPageWorkerPositionData?
    lazy var dataManager: MyPageWorkerPositionDatamanager = MyPageWorkerPositionDatamanager()
    //var numberOfCells: Int = 5
    var jobTitle = ""
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        showIndicator()
        dataManager.getMyPageWorkerPosition(vc: self)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageWorkerPositionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageWorkerPositionTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 401
    }
    


}

//MARK:- Table View Data Source

extension MyPageWorkerPositionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageWorkerPositionTableViewCell") as? MyPageWorkerPositionTableViewCell {
            
            if let data = positionInfo{
                cell.breakTimeLabel.text = "휴게시간 " + data.breakTime!
                if data.salaryType == 0{
                    cell.salaryLabel.text = "시급 " + data.salary!.insertComma +  "원"
                }else if data.salaryType == 1{
                    cell.salaryLabel.text = "주급 " + data.salary!.insertComma +  "원"
                }else{
                    cell.salaryLabel.text = "월급 " + data.salary!.insertComma +  "원"
                }
                cell.workDayLabel.text = data.workDay!
                let workTime = data.workTime!.insertWorkTime
                cell.workTimeLabel.text = "\(data.startTime!.insertTime) ~ \(data.endTime!.insertTime) \(workTime)"
                cell.positionLabel.text = jobTitle
            }
            
            
            print(indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 401
    }
    
    
}


//MARK:- Scroll View Actions

extension MyPageWorkerPositionVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageWorkerPositionTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageWorkerPositionTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageWorkerPositionTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageWorkerPositionTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageWorkerPositionTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}
extension MyPageWorkerPositionVC {
    func didSuccessMyPageWorkerPosition(result: MyPageWorkerPositionResponse) {
        
        positionInfo = result.data
        print(result.message!)
        
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageWorkerPosition(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

