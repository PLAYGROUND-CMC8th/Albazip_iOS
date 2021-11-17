//
//  MyPageManagerWorkerDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/08.
//

var detailTopViewInitialHeight : CGFloat = 186

import Foundation
import UIKit
import Kingfisher
class MyPageManagerWorkerDetailVC: BaseViewController{
    //MARK:- Change this value for number of tabs.
    
    let tabsCount = 3; #warning ("< 1 causes crash")
    
    //MARK:- Outlets
    //스티키 레이아웃 구성요소들
    @IBOutlet var stickyHeaderView: UIView!
    @IBOutlet var tabBarCollectionView: UICollectionView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var headerViewHeightConstraint: NSLayoutConstraint!
    
    //알바생 상단 정보
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var workerPositionLabel: UILabel!
    @IBOutlet var workerRankLabel: UILabel!
    @IBOutlet var workerNameLabel: UILabel!
    
    @IBOutlet var modalBgView: UIView!
    
    //MARK:- Programatic UI Properties
    
    var pageViewController = UIPageViewController()
    var selectedTabView = UIView()
    //선택된 탭 인덱스
    var selectedTabIndex = 0
    var firstName = ""
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    var status = 0
    // Datamanager
    lazy var dataManager: MyPageManagerWorkerDetailProfileDataManger = MyPageManagerWorkerDetailProfileDataManger()
    //투데이 데이터
    var profileData: MyPageManagerWorkerDetailProfileData?
    //MARK:- View Model
    
    var pageCollection = PageCollection()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPagingViewController()
        populateBottomView()
        addPanGestureToTopViewAndCollectionView()
        setUI()
        showIndicator()
        dataManager.getMyPageManagerWorkerDetailProfile(vc: self, index: positionId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("MainviewWillAppear")
        //퇴사 알림창 띄워주기!
        if status == 2{
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageManagerWorkerExitVC") as? MyPageManagerWorkerExitVC {
                vc.modalPresentationStyle = .overFullScreen
                vc.name = firstName
                
                //myPageManagerWorkerPositionAlertDelegate?.modalShow()
                
            self.present(vc, animated: true, completion: nil)
        }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("MainviewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        print("MainviewWillDisappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        print("MainviewDidDisappear")
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageManagerEditWorkerVC") as? MyPageManagerEditWorkerVC else {return}
        
        nextVC.positionId = positionId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    //MARK: View Setup
    func setUI(){
        //이미지뷰 동그랗게
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        modalBgView.isHidden = true
    }
    
    func setupCollectionView() {
        
        let layout = tabBarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: 100, height: 50)
        
        tabBarCollectionView.register(UINib(nibName: "MyPageTabBarCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "MyPageTabBarCollectionViewCell")
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        
        setupSelectedTabView()
    }
    
    func setupSelectedTabView() {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        label.text = "근무자 정보"//"TAB \(1)"
        label.sizeToFit()
        let width = label.intrinsicContentSize.width
        
        selectedTabView.frame = CGRect(x: 24, y: 51, width: width, height: 2)
        selectedTabView.backgroundColor = #colorLiteral(red: 0.1990817189, green: 0.2041014135, blue: 0.2039682269, alpha: 1)
        tabBarCollectionView.addSubview(selectedTabView)
    }
    
    func setupPagingViewController() {
        
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    //상단 탭바 글씨 지정
    func populateBottomView() {
        
        let tabName = ["근무자 정보", "포지션 정보", "업무 리스트"]
        for subTabCount in 0..<tabsCount {
            
            
            if(subTabCount==0){
                let tabContentVC = MyPageManagerWorkerInfoVC()
                tabContentVC.myPageManagerWorkerInfoTableViewScrollDelegate = self
                tabContentVC.positionId = self.positionId
                tabContentVC.status = self.status
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }else if(subTabCount==1){
                let tabContentVC = MyPageManagerWorkerPositionVC()
                tabContentVC.myPageManagerWorkerPositionTableViewScrollDelegate = self
                tabContentVC.positionId = self.positionId
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }else if(subTabCount==2){
                let tabContentVC = MyPageManagerWorkerWriteVC()
                tabContentVC.myPageManagerWorkerWriteTableViewScrollDelegate = self
                tabContentVC.positionId = self.positionId
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }
            
        }
        
        let initialPage = 0
        
        pageViewController.setViewControllers([pageCollection.pages[initialPage].vc],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        
        
        addChild(pageViewController)
        pageViewController.willMove(toParent: self)
        bottomView.addSubview(pageViewController.view)
        
        pinPagingViewControllerToBottomView()
    }
    
    func pinPagingViewControllerToBottomView() {
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.view.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }

    func addPanGestureToTopViewAndCollectionView() {
        
        let topViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
        
        stickyHeaderView.isUserInteractionEnabled = true
        stickyHeaderView.addGestureRecognizer(topViewPanGesture)
        
        /* Adding pan gesture to collection view is overriding the collection view scroll.
         
        let collViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
        
        tabBarCollectionView.isUserInteractionEnabled = true
        tabBarCollectionView.addGestureRecognizer(collViewPanGesture)
         
        */
    }
    
    var dragInitialY: CGFloat = 0
    var dragPreviousY: CGFloat = 0
    var dragDirection: DragDirection = .Up
    
    @objc func topViewMoved(_ gesture: UIPanGestureRecognizer) {
        
        var dragYDiff : CGFloat
        
        switch gesture.state {
            
        case .began:
            
            dragInitialY = gesture.location(in: self.view).y
            dragPreviousY = dragInitialY
            
        case .changed:
            
            let dragCurrentY = gesture.location(in: self.view).y
            dragYDiff = dragPreviousY - dragCurrentY
            dragPreviousY = dragCurrentY
            dragDirection = dragYDiff < 0 ? .Down : .Up
            innerTableViewDidScroll(withDistance: dragYDiff)
            
        case .ended:
            
            innerTableViewScrollEnded(withScrollDirection: dragDirection)
            
        default: return
        
        }
    }
    
    //MARK:- UI Laying Out Methods
    
    func setBottomPagingView(toPageWithAtIndex index: Int, andNavigationDirection navigationDirection: UIPageViewController.NavigationDirection) {
        
        pageViewController.setViewControllers([pageCollection.pages[index].vc],
                                                  direction: navigationDirection,
                                                  animated: true,
                                                  completion: nil)
    }
    
    func scrollSelectedTabView(toIndexPath indexPath: IndexPath, shouldAnimate: Bool = true) {
        
        UIView.animate(withDuration: 0.3) {
            
            if let cell = self.tabBarCollectionView.cellForItem(at: indexPath) {
                
                self.selectedTabView.frame.size.width = cell.frame.width
                self.selectedTabView.frame.origin.x = cell.frame.origin.x
            }
        }
    }
}
    

//MARK:- Collection View Data Source

extension MyPageManagerWorkerDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pageCollection.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageTabBarCollectionViewCell", for: indexPath) as? MyPageTabBarCollectionViewCell {
            
            tabCell.tabNameLabel.text = pageCollection.pages[indexPath.row].name
            //선택된 셀만 텍스트 컬러 진하게
            if(indexPath.row == selectedTabIndex){
                tabCell.tabNameLabel.textColor = #colorLiteral(red: 0.1990817189, green: 0.2041014135, blue: 0.2039682269, alpha: 1)
                tabCell.tabNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
            }else{
                tabCell.tabNameLabel.textColor = #colorLiteral(red: 0.886187017, green: 0.8863359094, blue: 0.8904727101, alpha: 1)
                tabCell.tabNameLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
            }
            return tabCell
        }
        
        return UICollectionViewCell()
    }
}

//MARK:- Collection View Delegate

extension MyPageManagerWorkerDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == pageCollection.selectedPageIndex {
            
            return
        }
        
        var direction: UIPageViewController.NavigationDirection
        
        if indexPath.item > pageCollection.selectedPageIndex {
            
            direction = .forward
            
        } else {
            
            direction = .reverse
        }
        
        pageCollection.selectedPageIndex = indexPath.item
        
        tabBarCollectionView.scrollToItem(at: indexPath,
                                          at: .centeredHorizontally,
                                          animated: true)
        
        scrollSelectedTabView(toIndexPath: indexPath)
        
        setBottomPagingView(toPageWithAtIndex: indexPath.item, andNavigationDirection: direction)
        
        // 선택된 셀이라면 텍스트 색상 진하게 변경
        selectedTabIndex = indexPath.row
        //선택 안된 셀이라면 텍스트 색상 디폴트 값, 연하게
        tabBarCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(section == 0){
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
}

//MARK:- Delegate Method to give the next and previous View Controllers to the Page View Controller

extension MyPageManagerWorkerDetailVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (1..<pageCollection.pages.count).contains(currentViewControllerIndex) {
                
                // go to previous page in array
                
                return pageCollection.pages[currentViewControllerIndex - 1].vc
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (0..<(pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                
                // go to next page in array
                
                return pageCollection.pages[currentViewControllerIndex + 1].vc
            }
        }
        return nil
    }
}

//MARK:- Delegate Method to tell Inner View Controller movement inside Page View Controller
//MARK:- Page View Controller 내부의 Inner View Controller 움직임을 알려주는 Delegate 메서드
//Capture it and change the selection bar position in collection View
//캡처하고 컬렉션 뷰에서 선택 막대 위치를 변경합니다.
extension MyPageManagerWorkerDetailVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        
        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
        
        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
        
        scrollSelectedTabView(toIndexPath: indexPathAtCollectionView)
        tabBarCollectionView.scrollToItem(at: indexPathAtCollectionView,
                                          at: .centeredHorizontally,
                                          animated: true)
    }
}

//MARK:- Sticky Header Effect

extension MyPageManagerWorkerDetailVC: MyPageManagerWorkerInfoTableViewScrollDelegate, MyPageManagerWorkerPositionTableViewScrollDelegate, MyPageManagerWorkerWriteTableViewScrollDelegate {
    
    var currentHeaderHeight: CGFloat {
        
        return headerViewHeightConstraint.constant
    }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat) {
       
        headerViewHeightConstraint.constant -= scrollDistance
        
         //Don't restrict the downward scroll.
 
        if headerViewHeightConstraint.constant > detailTopViewInitialHeight {

            /*
            showIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.dismissIndicator()
            }
            */
            
            
            headerViewHeightConstraint.constant = detailTopViewInitialHeight
            //bottomViewTopConstraint.constant += scrollDistance
        }
         
        if headerViewHeightConstraint.constant < topViewFinalHeight {
            
            headerViewHeightConstraint.constant = topViewFinalHeight
        }
    }
    
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection) {
        
        let topViewHeight = headerViewHeightConstraint.constant
        
        /*
         *  Scroll is not restricted.
         *  So this check might cause the view to get stuck in the header height is greater than initial height.
 
        if topViewHeight >= detailTopViewInitialHeight || topViewHeight <= topViewFinalHeight { return }
         
        */
        
        if topViewHeight <= topViewFinalHeight + 20 {
            
            scrollToFinalView()
            
        } else if topViewHeight <= detailTopViewInitialHeight - 20 {
            
            switch scrollDirection {
                
            case .Down: scrollToInitialView()
            case .Up: scrollToFinalView()
            
            }
            
        } else {
            
            scrollToInitialView()
        }
    }
    
    func scrollToInitialView() {
        
        let topViewCurrentHeight = stickyHeaderView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - detailTopViewInitialHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint.constant = detailTopViewInitialHeight
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollToFinalView() {
        
        let topViewCurrentHeight = stickyHeaderView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewFinalHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint.constant = topViewFinalHeight
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
}

extension MyPageManagerWorkerDetailVC : MyPageManagerWorkerPositionAlertDelegate{
    func modalDismiss() {
        print("modalDismiss")
        modalBgView.isHidden = true
    }
    func modalShow(){
        print("modalShow")
        modalBgView.isHidden = false
    }
    
    
}
extension MyPageManagerWorkerDetailVC {
    func didSuccessMyPageManagerWorkerDetailProfile(result: MyPageManagerWorkerDetailProfileResponse) {
        profileData = result.data
        
        print(result.message!)
        //profileImage.image = .none
        if let img = profileData?.imagePath{
            let url = URL(string: img)
            profileImage.kf.setImage(with: url)
        }else{ // 이미지 널이면 디폴트 이미지 넣자
            if status == 0{
                profileImage.image =  #imageLiteral(resourceName: "imgProfileNone84Px")
            }else{
                profileImage.image = #imageLiteral(resourceName: "imgProfileW128Px2")
            }
        }
        
        
        workerRankLabel.text = profileData?.rank!
        workerNameLabel.text = profileData?.firstName!
        workerPositionLabel.text  = profileData?.title!
        dismissIndicator()
    }
    
    func failedToRequestMyPageManagerWorkerDetailProfile(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
