//
//  MyPageWorkerWriteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

protocol MyPageWorkerWriteTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MyPageWorkerWriteVC: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    //MARK:- Scroll Delegate
    
    weak var myPageWorkerWriteTableViewScrollDelegate: MyPageWorkerWriteTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    
    var numberOfCells: Int = 5
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }


    //MARK:- View Setup
    
    func setupTableView() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "MyPageWorkerWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageWorkerWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 204
    }

}

//MARK:- Table View Data Source

extension MyPageWorkerWriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageWorkerWriteTableViewCell") as? MyPageWorkerWriteTableViewCell {
                
                //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                print(indexPath.row)
            return cell
            
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 204
        
    }
    
    
}

//MARK:- Scroll View Actions

extension MyPageWorkerWriteVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageWorkerWriteTableViewScrollDelegate?.currentHeaderHeight
        
        if let topViewUnwrappedHeight = topViewCurrentHeightConst {
            
            
            if delta > 0,
                topViewUnwrappedHeight > topViewHeightConstraintRange.lowerBound,
                scrollView.contentOffset.y > 0 {
                
                dragDirection = .Up
                myPageWorkerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
            
            
            if delta < 0,
                // topViewUnwrappedHeight < topViewHeightConstraintRange.upperBound,
                scrollView.contentOffset.y < 0 {
                
                dragDirection = .Down
                myPageWorkerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageWorkerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageWorkerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}
