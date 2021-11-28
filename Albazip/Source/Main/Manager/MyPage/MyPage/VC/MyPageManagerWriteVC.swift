//
//  MyPageManagerWriteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/31.
//

import UIKit

protocol MyPageManagerWriteTableViewScrollDelegate: AnyObject {
    
    var currentHeaderHeight: CGFloat { get }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat)
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection)
}

class MyPageManagerWriteVC: UIViewController, MyPageManagerWriteTabDelegate  {
    
    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK:- Scroll Delegate
    
    weak var myPageManagerWriteTableViewScrollDelegate: MyPageManagerWriteTableViewScrollDelegate?
    
    //MARK:- Stored Properties for Scroll Delegate
    
    private var dragDirection: DragDirection = .Up
    private var oldContentOffset = CGPoint.zero
    
    //MARK:- Data Source
    // Datamanager
    lazy var dataManager: MyPageManagerWriteDatamanager = MyPageManagerWriteDatamanager()
    //
    // Datamanager
    lazy var dataManager2: CommunityManagerNoticePinDatamanager = CommunityManagerNoticePinDatamanager()
    var writeData: [MyPageManagerWritePostInfo]?
    var noticeData: [MyPageManagerWriteNoticeInfo]?
    var isNoWriteData = true
    var isNoNoticeData = true
    
    //var numberOfCells: Int = 10
    //선택됨 탭
    var selectedTab = 0
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear2")
        showIndicator()
        dataManager.getMyPageManagerWrite(vc: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("viewDidAppear2")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        print("viewWillDisappear2")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        print("viewDidDisappear2")
    }
    //MARK:- View Setup
    
    func setupTableView() {
        //여백셀
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "MyPageManagerWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWriteTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWriteTabTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWriteTabTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWriteCommunityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWriteCommunityTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        
        
        //핀 새로 추가
        tableView.register(UINib(nibName: "CommunityManagerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerNoticeTableViewCell")
        
        //MyPageManagerNoWriteTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }

    //tab Delegate
    func changeTab(index: Int) {
        selectedTab = index
        tableView.reloadData()
    }
}

//MARK:- Table View Data Source

extension MyPageManagerWriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedTab == 0{
            if isNoNoticeData{
                return 2
            }else{
                return noticeData!.count //+ 1
            }
        }else{
            if isNoWriteData{
                return 2
            }else{
                return writeData!.count //+ 1
            }
        }
        
        // 1은 디폴트 공지사항, 게시판 버튼탭 셀임
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWriteTabTableViewCell") as? MyPageManagerWriteTabTableViewCell {
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        }*/
        //게시판 추가되면 indexPath.row에 -1 해줘야함.
        
            if(selectedTab==0){ // 공지사항일때
                if isNoNoticeData{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                        cell.selectionStyle = .none
                        cell.titleLabel.text = "작성한 글이 없어요."
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerNoticeTableViewCell") as? CommunityManagerNoticeTableViewCell {
                        cell.selectionStyle = .none
                        cell.delegate = self
                        cell.bgView.backgroundColor = #colorLiteral(red: 0.9724535346, green: 0.9726160169, blue: 0.9724321961, alpha: 1)
                        if let data = noticeData{
                            let date = data[indexPath.row].registerDate!.substring(from: 0, to: 10)
                            print(date)
                            let date2 = date.replace(target: "-", with: ". ")
                            cell.subLabel.text = date2
                            cell.titleLabel.text = data[indexPath.row].title!
                            if data[indexPath.row].pin! == 0{
                                cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinInactive"), for: .normal)
                            }else{
                                cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinActive"), for: .normal)
                            }
                            cell.noticeId = data[indexPath.row].id!
                        }
                        print(indexPath.row)
                        return cell
                    }
                }
                
            }else{ //게시판 일때
                if isNoNoticeData{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                        cell.selectionStyle = .none
                        cell.titleLabel.text = "작성한 글이 없어요."
                        print(indexPath.row)
                        return cell
                    }
                }else{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWriteCommunityTableViewCell") as? MyPageManagerWriteCommunityTableViewCell {
                        
                        cell.selectionStyle = .none
                        if let data = writeData{
                            cell.nameLabel.text = data[indexPath.row - 1].writerName!
                            cell.commentLabel.text = String(data[indexPath.row - 1].commentCount!)
                            let date = data[indexPath.row - 1].registerDate!.substring(from: 0, to: 10)
                            print(date)
                            let date2 = date.replace(target: "-", with: ". ")
                            cell.dateLabel.text = date2
                            cell.positionLabel.text = data[indexPath.row - 1].writerJob!
                            cell.subLabel.text = data[indexPath.row - 1].content!
                            cell.titleLabel.text = data[indexPath.row - 1].title!
                            print(indexPath.row)
                        }
                     
                        return cell
                    }
                }
                
            }
            
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        /*
        if indexPath.row == 0{
            return 51
        }*/
        
        //else{
            
            
            if selectedTab == 0{
                if isNoNoticeData{
                    return 326
                }else{
                    return 97
                }
            }else{
                if isNoWriteData{
                    return 326
                }else{
                    return 175
                }
            }
        //}
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoNoticeData{
            if let data = noticeData{
                let newStoryboard = UIStoryboard(name: "CommunityManagerStoryboard", bundle: nil)
                guard let nextVC = newStoryboard.instantiateViewController(identifier: "CommunityManagerNoticeDetailVC") as? CommunityManagerNoticeDetailVC else {return}
                //nextVC.confirm = data[index].confirm!
                nextVC.noticeId = data[indexPath.row].id!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
}

//MARK:- Scroll View Actions

extension MyPageManagerWriteVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        
        let topViewCurrentHeightConst = myPageManagerWriteTableViewScrollDelegate?.currentHeaderHeight
        
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
                myPageManagerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
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
                myPageManagerWriteTableViewScrollDelegate?.innerTableViewDidScroll(withDistance: delta)
                scrollView.contentOffset.y -= delta
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if scrollView.contentOffset.y <= 0 {
            
            myPageManagerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //You should not bring the view down until the table view has scrolled down to it's top most cell.
        
        if decelerate == false && scrollView.contentOffset.y <= 0 {
            
            myPageManagerWriteTableViewScrollDelegate?.innerTableViewScrollEnded(withScrollDirection: dragDirection)
        }
    }
}

extension MyPageManagerWriteVC {
    func didSuccessMyPageManagerWrite(result: MyPageManagerWriteResponse) {
        writeData = result.data?.postInfo
        noticeData = result.data?.noticeInfo
        print(result.message!)
        if writeData!.count != 0{
            isNoWriteData = false
        }else{
            isNoWriteData = true
        }
        
        if noticeData!.count != 0{
            isNoNoticeData = false
        }else{
            isNoNoticeData = true
        }
        print("\(isNoWriteData) \(isNoNoticeData)" )
        tableView.reloadData()
        dismissIndicator()
        
    }
    
    func failedToRequestMyPageManagerWrite(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}
// 핀 api
extension MyPageManagerWriteVC: CommunityManagerNoticeDelegate{
    func pinAPI(noticeId:Int) {
        print("핀 api 호출 \(noticeId)")
        dataManager2.getCommunityManagerNoticePin(noticeId: noticeId, vc: self)
    }
    
    
}
extension MyPageManagerWriteVC {
    //공지사항 핀 aPI
    
    //핀 성공
    func didSuccessCommunityManagerNoticePin(result: CommunityManagerNoticePinResponse) {
        print(result.message)
        dataManager.getMyPageManagerWrite(vc: self)
    }
    //핀 5개 초과시
    func didSuccessCommunityManagerNoticePinOver(message: String) {
        
        dismissIndicator()
        presentBottomAlert(message: message)
    }
    //핀 실패
    func failedToRequestCommunityManagerNoticePin(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
