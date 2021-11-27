//
//  MyPageWorkerVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/02.
//

import Foundation
import UIKit

class MyPageWorkerVC: BaseViewController{
    
    //MARK:- Change this value for number of tabs.
    
    let tabsCount = 3; #warning ("< 1 causes crash")
    
    //MARK:- Outlets
    
    @IBOutlet var stickyHeaderView: UIView!
    @IBOutlet var tabBarCollectionView: UICollectionView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var modalBgView: UIView!
    @IBOutlet var profileImage: UIImageView!
    
    //MARK:- Programatic UI Properties
    
    var pageViewController = UIPageViewController()
    var selectedTabView = UIView()
    //선택된 탭 인덱스
    var selectedTabIndex = 0
    
    // Datamanager
    lazy var dataManager: MyPageWorkerProfileDatamanager = MyPageWorkerProfileDatamanager()
    //
    var profileData: MyPageManagerProfileData?
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var jobTitle = ""
    //MARK:- View Model
    
    var pageCollection = PageCollection()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //showIndicator()
        //dataManager.getMyPageManagerProfile(vc: self)
        //버그 BUG: 프로필 사진 바꾸면 다시 리로드 되어야함
        setupCollectionView()
        setupPagingViewController()
        populateBottomView()
        addPanGestureToTopViewAndCollectionView()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("MainviewWillAppear")
        showIndicator()
        dataManager.getMyPageManagerProfile(vc: self)
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
    
    //MARK: View Setup
    func setUI(){
        //이미지뷰 동그랗게
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        modalBgView.isHidden = true
    }
    @IBAction func btnProfileImage(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageWorkerSelectProfileImageVC") as? MyPageWorkerSelectProfileImageVC {
                    vc.modalPresentationStyle = .overFullScreen
                    
            modalBgView.isHidden = false
            vc.selectProfileImageDelegate = self
            if let x = profileImage.image{
                vc.selectedImage = x
                
            }
            if let x = profileData {
                if let y = x.imagePath{
                    vc.imageUrl = y
                }
            }
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        let newStoryboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
        guard let nextVC = newStoryboard.instantiateViewController(identifier: "SettingWorkerVC") as? SettingWorkerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        label.text = "내정보"//"TAB \(1)"
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
        
        //let tabName = ["내정보", "포지션", "작성글"]
        let tabName = ["내정보", "포지션"]
        for subTabCount in 0..<tabsCount {
            
            
            if(subTabCount==0){
                let tabContentVC = MyPageWorkerInfoVC()
                tabContentVC.myPageWorkerInfoTableViewScrollDelegate = self
                //tabContentVC.numberOfCells = 30
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }else if(subTabCount==1){
                let tabContentVC = MyPageWorkerPositionVC()
                tabContentVC.myPageWorkerPositionTableViewScrollDelegate = self
                
                //tabContentVC.numberOfCells = 30
                tabContentVC.jobTitle = jobTitle
                
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }
            /*
            else if(subTabCount==2){
                let tabContentVC = MyPageWorkerWriteVC()
                tabContentVC.myPageWorkerWriteTableViewScrollDelegate = self
                //tabContentVC.numberOfCells = 30
                let displayName = tabName[subTabCount]//"TAB \(subTabCount + 1)"
                let page = Page(with: displayName, _vc: tabContentVC)
                pageCollection.pages.append(page)
            }*/
            
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

extension MyPageWorkerVC: UICollectionViewDataSource {
    
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

extension MyPageWorkerVC: UICollectionViewDelegateFlowLayout {
    
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

extension MyPageWorkerVC: UIPageViewControllerDataSource {
    
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
extension MyPageWorkerVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        
        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
        
        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
        
        scrollSelectedTabView(toIndexPath: indexPathAtCollectionView)
        tabBarCollectionView.scrollToItem(at: indexPathAtCollectionView,
                                          at: .centeredHorizontally,
                                          animated: true)
        // FIX
        // 선택된 셀이라면 텍스트 색상 진하게 변경
        selectedTabIndex = currentVCIndex
        //선택 안된 셀이라면 텍스트 색상 디폴트 값, 연하게
        tabBarCollectionView.reloadData()
    }
}

//MARK:- Sticky Header Effect

extension MyPageWorkerVC: MyPageWorkerInfoTableViewScrollDelegate, MyPageWorkerPositionTableViewScrollDelegate, MyPageWorkerWriteTableViewScrollDelegate {
    
    var currentHeaderHeight: CGFloat {
        
        return headerViewHeightConstraint.constant
    }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat) {
       
        headerViewHeightConstraint.constant -= scrollDistance
        
         //Don't restrict the downward scroll.
 
        if headerViewHeightConstraint.constant > topViewInitialHeight {

            /*
            showIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.dismissIndicator()
            }
            */
            
            
            headerViewHeightConstraint.constant = topViewInitialHeight
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
 
        if topViewHeight >= topViewInitialHeight || topViewHeight <= topViewFinalHeight { return }
         
        */
        
        if topViewHeight <= topViewFinalHeight + 20 {
            
            scrollToFinalView()
            
        } else if topViewHeight <= topViewInitialHeight - 20 {
            
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
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewInitialHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint.constant = topViewInitialHeight
        
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

extension MyPageWorkerVC: SelectProfileImageDelegate{
    func imageModalDismiss(){
        modalBgView.isHidden = true
    }
    func changeImage(){
        print("이미지 변경")
        
        //profileImage.image = data
        showIndicator()
        dataManager.getMyPageManagerProfile(vc: self)
    }
}
extension MyPageWorkerVC {
    func didSuccessMyPageManagerProfile(result: MyPageManagerProfileResponse) {
        dismissIndicator()
        profileData = result.data
        print(profileData)
        print(result.message!)
        if let img = profileData?.imagePath{
            let url = URL(string: img)
            profileImage.kf.setImage(with: url)
        }else{
            profileImage.image = #imageLiteral(resourceName: "imgProfile84Px1")
        }
        positionLabel.text = profileData?.jobTitle!
        storeNameLabel.text = profileData?.shopName!
        nameLabel.text = "\(profileData!.firstName!)"
        jobTitle = (profileData?.jobTitle!)!
        
        //setupCollectionView()
        //setupPagingViewController()
        //populateBottomView()
        //addPanGestureToTopViewAndCollectionView()
        //setUI()
    }
    
    func failedToRequestMyPageManagerProfile(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

