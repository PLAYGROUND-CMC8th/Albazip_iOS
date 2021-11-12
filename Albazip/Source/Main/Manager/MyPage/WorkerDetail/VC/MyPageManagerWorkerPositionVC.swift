//
//  MyPageManagerWorkerPositionVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/08.
//

import UIKit

protocol MyPageManagerWorkerPositionTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

protocol MyPageManagerWorkerPositionAlertDelegate {
    func modalShow()
}


class MyPageManagerWorkerPositionVC: UIViewController, MyPageManagerWorkerPositionDeleteDelegate {
    
    
    

    
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var myPageManagerWorkerPositionTableViewScrollDelegate: MyPageManagerWorkerPositionTableViewScrollDelegate?
    
    var myPageManagerWorkerPositionAlertDelegate: MyPageManagerWorkerPositionAlertDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    var transparentView = UIView()
    var positionInfo: MyPageManagerWorkerPositionData?
    lazy var dataManager: MyPageManagerWorkerPositionDatamanager = MyPageManagerWorkerPositionDatamanager()
    var positionId = 0
    //MARK:- View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        showIndicator()
        dataManager.getMyPageManagerWorkerPosition(vc: self, index: positionId)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerWorkerPositionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkerPositionTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkerPositionDeleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkerPositionDeleteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 401
    }
    
    //포지션 삭제 버튼
    func deletePosition() {
        print("삭제 버튼")
        let newStoryboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: nil)
        
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerPositionDeleteVC") as? MyPageManagerWorkerPositionDeleteVC {
            vc.modalPresentationStyle = .overFullScreen
            myPageManagerWorkerPositionAlertDelegate?.modalShow()
            
        self.present(vc, animated: true, completion: nil)
    }
    }
}



//MARK:- Table View Data Source

extension MyPageManagerWorkerPositionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkerPositionTableViewCell") as? MyPageManagerWorkerPositionTableViewCell {
                
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
                }
                print(indexPath.row)
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkerPositionDeleteTableViewCell") as? MyPageManagerWorkerPositionDeleteTableViewCell {
                cell.myPageManagerWorkerPositionDeleteDelegate = self
                
                //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                print(indexPath.row)
                return cell
            }
        }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.row == 0{
            return 330
        }else {
            return 50
        }
        
    }
    
    
}


//MARK:- Scroll View Actions

extension MyPageManagerWorkerPositionVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageManagerWorkerPositionTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageManagerWorkerPositionTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageManagerWorkerPositionTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerPositionTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerPositionTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}
extension MyPageManagerWorkerPositionVC {
    func didSuccessMyPageManagerWorkerPosition(result: MyPageManagerWorkerPositionResponse) {
        
        positionInfo = result.data
        print(result.message!)
        
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageManagerWorkerPosition(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

