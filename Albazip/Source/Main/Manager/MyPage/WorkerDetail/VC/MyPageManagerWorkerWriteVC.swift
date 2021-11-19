//
//  MyPageManagerWorkerWriteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/08.
//

import UIKit

protocol MyPageManagerWorkerWriteTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MyPageManagerWorkerWriteVC: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var myPageManagerWorkerWriteTableViewScrollDelegate: MyPageManagerWorkerWriteTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    var workListData: [MyPageManagerWorkerWriteData]?
    lazy var dataManager: MyPageManagerWorkerWriteDatamanager = MyPageManagerWorkerWriteDatamanager()
    var numberOfCells: Int = 5
    var positionId = 0
    var isNoWorkList = true
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        //showIndicator()
        //dataManager.getMyPageManagerWorkerWrite(vc: self, index: positionId)
    }
    override func viewWillAppear(_ animated: Bool) {
        showIndicator()
        dataManager.getMyPageManagerWorkerWrite(vc: self, index: positionId)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "MyPageManagerWorklistTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorklistTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        //MyPageManagerNoWriteTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 204
    }
}
//MARK:- Table View Data Source

extension MyPageManagerWorkerWriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNoWorkList{
            return 1
        }else{
            if let data = workListData{
                return data.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isNoWorkList{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                   
               cell.selectionStyle = .none //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                cell.titleLabel.text = "작성한 업무리스트가 없어요."
                   print(indexPath.row)
               return cell
               
           }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorklistTableViewCell") as? MyPageManagerWorklistTableViewCell {
                   
               cell.selectionStyle = .none //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
               if let data = workListData{
                   cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                   cell.titleLabel.text = data[indexPath.row].title!
               }
                   print(indexPath.row)
               return cell
               
           }
        }
         
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if isNoWorkList{
            return 375
        }else{
            return 82
        }

        
    }
    
    
}

//MARK:- Scroll View Actions

extension MyPageManagerWorkerWriteVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageManagerWorkerWriteTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageManagerWorkerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageManagerWorkerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageManagerWorkerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}
extension MyPageManagerWorkerWriteVC {
    func didSuccessMyPageManagerWorkerWrite(result: MyPageManagerWorkerWriteResponse) {
        
        workListData = result.data
        print(result.message!)
        if workListData!.count != 0{
            isNoWorkList = false
        } else{
            isNoWorkList = true
        }
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageManagerWorkerWrite(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

