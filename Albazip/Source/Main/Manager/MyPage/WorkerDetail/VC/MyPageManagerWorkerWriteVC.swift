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
    var isFolded = [Bool]()
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
        
        //미완료 펼쳤을때 버전 137
        tableView.register(UINib(nibName: "MyPageDetailNoClearWorkOpenTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell")
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
            // 접폈는지 펴졌는지
            if isFolded[indexPath.row]{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorklistTableViewCell") as? MyPageManagerWorklistTableViewCell {
                       
                   cell.selectionStyle = .none //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                   if let data = workListData{
                       cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                       cell.titleLabel.text = data[indexPath.row].title!
                   }
                       print(indexPath.row)
                   return cell
                   
               }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkOpenTableViewCell") as? MyPageDetailNoClearWorkOpenTableViewCell {
                    
                   cell.selectionStyle = .none //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                   if let data = workListData{
                    cell.bgView.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
                       cell.subLabel.text = data[indexPath.row].content ?? "내용 없음"
                       cell.titleLabel.text = data[indexPath.row].title!
                    
                    let position = data[indexPath.row].writerTitle ?? ""
                    let name = data[indexPath.row].writerName ?? ""
                    let date = data[indexPath.row].registerDate!.insertDate
                    cell.writerNameLabel.text = position + " " + name + " · " + date
                   }
                       print(indexPath.row)
                   return cell
                   
               }
            }
            
        }
         
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if isNoWorkList{
            return 375
        }else{
            if isFolded[indexPath.row] == true{
                return 82
            }else{
                return 137
            }
        }

        
    }
    
    // Select Cell

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("\(indexPath.section): \(indexPath.row)")
        if !isNoWorkList{
          if isFolded[indexPath.row] == true{
                    isFolded[indexPath.row] = false
                    tableView.reloadData()
            }else{
                isFolded[indexPath.row] = true
                tableView.reloadData()
            }
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
            // 테이블뷰 접고 펴기 배열
            var i = 0
            while i < workListData!.count{
                isFolded.append(true)
                i += 1
            }
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

