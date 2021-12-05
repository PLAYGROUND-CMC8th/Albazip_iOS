//
//  CommunityManagerTopTabVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import XLPagerTabStrip
class CommunityManagerTopTabVC: ButtonBarPagerTabStripViewController{
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    }
    func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white

        settings.style.buttonBarItemFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)!
        settings.style.buttonBarItemTitleColor = .gray
        
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        settings.style.buttonBarLeftContentInset = 16
        settings.style.buttonBarRightContentInset = 16

        settings.style.selectedBarHeight = 0.0
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor =  #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
        }
    }
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "CommunityManagerStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CommunityManagerNoticeVC")
        //let child1 = CommunityWorkerNoticeVC()
       
        //child_1.delegate = self
        return [child_1]
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int){
        print("\(fromIndex) to \(toIndex)")
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool){
        print("\(fromIndex) to \(toIndex)")
        
    }
    
    @IBAction func btnWrite(_ sender: Any) {
        //쓰기 버튼~
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerWriteVC") as? CommunityManagerWriteVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerSearchVC") as? CommunityManagerSearchVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnAlarm(_ sender: Any) {
        //CommunityManagerAlarmVC
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerAlarmVC") as? CommunityManagerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
