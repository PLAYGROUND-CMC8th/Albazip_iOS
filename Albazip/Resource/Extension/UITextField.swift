//
//  UITextField.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//

import UIKit

extension UITextField {
    
    // 텍스트 필드 왼쪽에 패딩 주기
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
    // 텍스트 필드 왼쪽에 패딩 주기
  func addLeftPadding2() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
    func addRightPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
      self.rightView = paddingView
      self.rightViewMode = ViewMode.always
    }
}
