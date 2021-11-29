//
//  BaseViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 아래 예시들처럼 상황에 맞게 활용하시면 됩니다.
        // Navigation Bar
//        self.navigationController?.navigationBar.titleTextAttributes = [
//            .font : UIFont.NotoSans(.medium, size: 16),
//        ]
        // Background Color
//        self.view.backgroundColor = .white
        
        // 네비게이션 바 없애기
        self.navigationController?.navigationBar.isHidden = true
        
        /*
        let navigationBarAppearace = UINavigationBar.appearance()
        //반투명 없애주기
        self.navigationController?.navigationBar.isTranslucent = false
        //내비 색상 변경
        navigationBarAppearace.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //내비 밑에 선 없애기
        self.navigationController?.navigationBar.shadowImage = UIImage()
 */
        //탭바 색 흰색으로
        tabBarController?.tabBar.barTintColor = .white
        //반투명 없애주기
        tabBarController?.tabBar.isTranslucent = false
        //탭바 밑에 선 없애기
        //tabBarController?.tabBar.shadowImage = UIImage()
        
        if #available(iOS 15, *) {
           let tabBarAppearance = UITabBarAppearance()
           tabBarAppearance.backgroundColor = .white
            /*
           tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
           tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]*/
            tabBarController?.tabBar.standardAppearance = tabBarAppearance
            //tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            /*
           UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
           UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)*/
            tabBarController?.tabBar.barTintColor = .white
         }
    }
}
