//
//  MyPageManagerWorkerInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/08.
//

import UIKit
protocol MyPageManagerWorkerInfoTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MyPageManagerWorkerInfoVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var myPageManagerWorkerInfoTableViewScrollDelegate: MyPageManagerWorkerInfoTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    
    var numberOfCells: Int = 1
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }


    //MARK:- View Setup
    
    func setupTableView() {
        //230
        tableView.register(UINib(nibName: "MyPageWorkerMyInfoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageWorkerMyInfoTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkerCodeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkerCodeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 473
    }

}
//MARK:- Table View Data Source

extension MyPageManagerWorkerInfoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageWorkerMyInfoTableViewCell") as? MyPageWorkerMyInfoTableViewCell {
            
            cell.delegate = self
            //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
            print(indexPath.row)
            return cell
        }*/
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkerCodeTableViewCell") as? MyPageManagerWorkerCodeTableViewCell {
            
            //cell.delegate = self
            //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
            print(indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 230 //473
    }
    
    
}

//MARK:- Scroll View Actions

extension MyPageManagerWorkerInfoVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageManagerWorkerInfoTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageManagerWorkerInfoTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageManagerWorkerInfoTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerInfoTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerInfoTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}


extension MyPageManagerWorkerInfoVC: MyPageWorkerMyInfoDelegate {

    func goCommuteRecordVC(){
        print("출퇴근 기록 페이지로..")
        let storyboard = UIStoryboard(name: "MyPageWorkerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MyPageDetailCommuteRecordVC") as? MyPageDetailCommuteRecordVC else {return}
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
