//
//  ManagerTabBarController.swift
//  Albazip
//
//  Created by 김수빈 on 2023/07/01.
//

import Foundation

class ManagerTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            if index == 2 {
                if let homeManagerNavigationController = tabBarController.viewControllers?.first as? UINavigationController,
                   let homeManagerVC = homeManagerNavigationController.viewControllers.first as? HomeManagerVC {
                    homeManagerVC.homeTooTip.isHidden = true
                }
            }
        }
    }
}
