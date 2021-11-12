//
//  MyPageManagerContentVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/30.
//

import UIKit

enum DragDirection {
    
    case Up
    case Down
}

protocol InnerTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}
//186
class MyPageManagerContentVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var innerTableViewScrollDelegate: InnerTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    
    var numberOfCells: Int = 0
    var isNoWorker = true
    var contentData: [MyPageManagerContentData]?
    lazy var dataManager: MyPageManagerContentDatamanager = MyPageManagerContentDatamanager()
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear")
        dataManager.getMyPageManagerContent(vc: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        print("viewDidDisappear")
    }
    
    

    //MARK:- View Setup
    //tableview cell에 들어갈 cell들의 Nib을 등록
    
    func setupTableView() {
        
        let curatingCellNib = UINib(nibName: "MyPageManagerWorkerTableViewCell", bundle: nil)
        self.tableView.register(curatingCellNib, forCellReuseIdentifier: "MyPageManagerWorkerTableViewCell")
        
        
        tableView.register(UINib(nibName: "MyPageManagerTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoWorkerTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWorkerTableViewCell")
        //MyPageManagerNoWorkerTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 1000
        
    }
    
    //근무자 추가 페이지로,. Delegate
    func goAddWorkerPage() {
        let storyboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: Bundle.main)
        guard let nextVC = storyboard.instantiateViewController(identifier: "MyPageManagerAddWorkerVC") as? MyPageManagerAddWorkerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

// 근무자 디테일 페이지로 이동
extension MyPageManagerContentVC: MyPageManagerWorkerCollectionViewCellDelegate{
    func collectionView(collectionviewcell: MyPageManagerWorkerCollectionViewCell?, index: Int, didTappedInTableViewCell: MyPageManagerWorkerTableViewCell) {
        let storyboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerDetailVC") as? MyPageManagerWorkerDetailVC else { return }
        //vc.index = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//MARK:- Table View Data Source

extension MyPageManagerContentVC: UITableViewDataSource, MyPageManagerNoWorkerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfCells // 무조건 한개
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isNoWorker{
            return 419
        }else{
            switch indexPath.row {
            case 0:
                return 578
            
            default:
                return 100
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isNoWorker{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWorkerTableViewCell") as? MyPageManagerNoWorkerTableViewCell {
                cell.delegate = self
                //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkerTableViewCell") as? MyPageManagerWorkerTableViewCell {
                cell.myPageManagerWorkerCollectionViewCellDelegate = self
                cell.setCell(data: contentData!)
                cell.totalCount.text = String(contentData!.count)
                return cell
            }
        }
        return UITableViewCell()
    }
}

//MARK:- Scroll View Actions

extension MyPageManagerContentVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = innerTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            /**
             *  Re-size (Shrink) the top view only when the conditions meet:-
             *  1. The current offset of the table view should be greater than the previous offset indicating an upward scroll.
             *  2. The top view's height should be within its minimum height.
             *  3. Optional - Collapse the header view only when the table view's edge is below the above view - This case will occur if you are using Step 2 of the next condition and have a refresh control in the table view.
             */
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                innerTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            /**
             *  Re-size (Expand) the top view only when the conditions meet:-
             *  1. The current offset of the table view should be lesser than the previous offset indicating an downward scroll.
             *  2. Optional - The top view's height should be within its maximum height. Skipping this step will give a bouncy effect. Note that you need to write extra code in the outer view controller to bring back the view to the maximum possible height.
             *  3. Expand the header view only when the table view's edge is below the header view, else the table view should first scroll till it's offset is 0 and only then the header should expand.
             */
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                innerTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            innerTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            innerTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}
extension MyPageManagerContentVC {
    func didSuccessMyPageManagerContent(result: MyPageManagerContentResponse) {
        contentData = result.data
       
        print(result.message!)
        if contentData!.count != 0{
            isNoWorker = false
        }else{
            isNoWorker = true
        }
        numberOfCells = 1
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageManagerContent(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}
