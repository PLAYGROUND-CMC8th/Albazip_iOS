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
    var status = -1
    //MARK:- View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
       // showIndicator()
        //dataManager.getMyPageManagerWorkerPosition(vc: self, index: positionId)
    }
    override func viewWillAppear(_ animated: Bool) {
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
        
        if status == 1{
            presentBottomAlert(message: "근무자가 등록된 상태에선 포지션을 삭제할 수 없습니다.")
        }else{
            if let vc = newStoryboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerPositionDeleteVC") as? MyPageManagerWorkerPositionDeleteVC {
                vc.myPageManagerWorkerPositionDeleteAlertDelegate = self
                vc.modalPresentationStyle = .overFullScreen
                vc.positionId = positionId
                myPageManagerWorkerPositionAlertDelegate?.modalShow()
                
            self.present(vc, animated: true, completion: nil)
            }
        
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
                    cell.setCell(data: data)
                }
                print(indexPath.row)
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkerPositionDeleteTableViewCell") as? MyPageManagerWorkerPositionDeleteTableViewCell {
                cell.myPageManagerWorkerPositionDeleteDelegate = self
                if status == 1{
                    cell.btnDelete.setTitleColor(#colorLiteral(red: 0.4304383695, green: 0.4354898334, blue: 0.4353147745, alpha: 1), for: .normal)
                    cell.btnDelete.backgroundColor = #colorLiteral(red: 0.9018717408, green: 0.902023077, blue: 0.9018517733, alpha: 1)
                }else{
                    cell.btnDelete.setTitleColor(#colorLiteral(red: 0.203897506, green: 0.2039385736, blue: 0.2081941962, alpha: 1), for: .normal)
                    cell.btnDelete.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
                }
                //cell.cellLabel.text = "This is cell \(indexPath.row + 1)"
                print(indexPath.row)
                return cell
            }
        }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.row == 0{
            return tableView.estimatedRowHeight
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

extension MyPageManagerWorkerPositionVC: MyPageManagerWorkerPositionDeleteAlertDelegate, MyPageManagerPositionDelete2VCDelegate{
    
    // 포지션 삭제 api 성공하면 이전 페이지로
    func successDeletePosition() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func modalDismiss() {
        print("modalDismiss")
    }
    
    //진짜 포지션 삭제하시겠습니까?
    func nextDeleteModal() {
        print("nextDeleteModal")
        let newStoryboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: nil)
        
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerPositionDelete2VC") as? MyPageManagerWorkerPositionDelete2VC {
            vc.delegate = self
            vc.positionId = positionId
            vc.modalPresentationStyle = .overFullScreen
            myPageManagerWorkerPositionAlertDelegate?.modalShow()
            self.present(vc, animated: true, completion: nil)
            /*
            guard let pvc = self.presentingViewController else { return }
                
            self.transparentView.isHidden = true
            self.dismiss(animated: false) {
              pvc.present(vc, animated: false, completion: nil)
                
            }*/
    }
    }
    
    
}
