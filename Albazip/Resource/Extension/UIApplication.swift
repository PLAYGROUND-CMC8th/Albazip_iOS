//
//  UIApplication.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import Foundation
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension UIWindow{
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController{
        if let nc = vc as? UINavigationController{
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        }else if let tc = vc as? UITabBarController{
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        }else{
            if let pvc = vc?.presentedViewController{
                return self.visibleViewControllerFrom(vc: pvc)
            }else{
                return vc!
            }
        }
    }
}
