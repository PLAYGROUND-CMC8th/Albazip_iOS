//
//  CommunityWorkerTopTabVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import Foundation
import XLPagerTabStrip
class CommunityWorkerTopTabVC: ButtonBarPagerTabStripViewController{
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
        //window?.rootViewController = UINavigationController(rootViewController: CommunityWorkerTopTabVC())
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
    @IBAction func btnSearch(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityWorkerSearchVC") as? CommunityWorkerSearchVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnAlarm(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityWorkerAlarmVC") as? CommunityWorkerAlarmVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "CommunityWorkerStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CommunityWorkerNoticeVC")
        
        //let child1 = CommunityWorkerNoticeVC()
     
        return [child_1]
    }
}
