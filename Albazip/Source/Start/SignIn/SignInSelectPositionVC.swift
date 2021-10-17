//
//  SignInSelectPositionVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import Foundation
import UIKit
class SignInSelectPositionVC: UIViewController{
    
    
    @IBOutlet weak var managerView: UIView!
    @IBOutlet weak var workerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewMap: View 객체
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(managerViewTapped))
        managerView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(workerViewTapped))
        workerView.addGestureRecognizer(tapGestureRecognizer2)

        
    }
    @objc func managerViewTapped(sender: UITapGestureRecognizer) {
        
    }
    @objc func workerViewTapped(sender: UITapGestureRecognizer) {
        
    }
    
    
    
}
