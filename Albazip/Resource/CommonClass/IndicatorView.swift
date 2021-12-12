//
//  IndicatorView.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

open class IndicatorView {
    static let shared = IndicatorView()
        
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    open func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        
        self.containerView.addSubview(self.activityIndicator)
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    open func showIndicator() {
        self.containerView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.color = UIColor(hex: 0x808080)
        self.activityIndicator.center = self.containerView.center
        
        self.activityIndicator.startAnimating()
    }
    
    open func dismiss() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
    
    // 커스텀 인디케이터
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    private var loadingSubLabel: UILabel?
    
    open class func customShow() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 152, height: 136))
        popupView.animationImages = IndicatorView.getAnimationImageArray()
        popupView.animationDuration = 0.8
        popupView.animationRepeatCount = 0
        
        let loadingLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
        loadingLabel.text = "잠시만 기다려주세요!"
        loadingLabel.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 18)
        loadingLabel.textColor = #colorLiteral(red: 1, green: 0.7672405243, blue: 0.01259230357, alpha: 1)
        loadingLabel.textAlignment = .center
        
        let loadingSubLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
        loadingSubLabel.text = "열심히 정보를 불러오고 있어요."
        loadingSubLabel.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 14)
        loadingSubLabel.textColor = #colorLiteral(red: 0.9950950742, green: 1, blue: 0.9999566674, alpha: 1)
        loadingSubLabel.textAlignment = .center
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            window.addSubview(loadingLabel)
            window.addSubview(loadingSubLabel)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            
            //popupView.center = window.center
            popupView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2,
                                       y: UIScreen.main.bounds.size.height / 2 - 30)
            popupView.startAnimating()
            
            loadingLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 8)
            loadingSubLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 33)
            
            shared.backgroundView?.removeFromSuperview()
            shared.popupView?.removeFromSuperview()
            shared.loadingLabel?.removeFromSuperview()
            shared.loadingSubLabel?.removeFromSuperview()
            shared.backgroundView = backgroundView
            shared.popupView = popupView
            shared.loadingLabel = loadingLabel
            shared.loadingSubLabel = loadingSubLabel
        }
    }
    
    open class func customHide() {
        if let popupView = shared.popupView,
            let loadingLabel = shared.loadingLabel,
            let backgroundView = shared.backgroundView, let loadingSubLabel = shared.loadingSubLabel {
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
            loadingLabel.removeFromSuperview()
            loadingSubLabel.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "LoadingBee")!)
        return animationArray
    }
}
