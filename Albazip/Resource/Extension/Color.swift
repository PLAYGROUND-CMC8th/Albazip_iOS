//
//  UIColor.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainYellow: UIColor { #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1)}
    class var blurYellow: UIColor { #colorLiteral(red: 1, green: 0.8823529412, blue: 0.4980392157, alpha: 1)}
    class var semiYellow: UIColor { #colorLiteral(red: 0.9983271956, green: 0.9391896129, blue: 0.7384549379, alpha: 1)}
    class var gray: UIColor { #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)}
    class var blurGray: UIColor { #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)}
    class var semiGray: UIColor{#colorLiteral(red: 0.678363204, green: 0.678479135, blue: 0.6783478856, alpha: 1)}
    
}
