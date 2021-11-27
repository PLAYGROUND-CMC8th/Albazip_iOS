//
//  HomeManagerClearAlertVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeManagerClearAlertVC: UIViewController{
    var transparentView = UIView()
    @IBOutlet var mainView: UIView!
    @IBOutlet var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        mainView.addGestureRecognizer(tapGestureRecognizer1)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(bgViewTapped))
        bgView.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    @objc func mainViewTapped(sender: UITapGestureRecognizer) {
        self.transparentView.isHidden = true
        self.dismiss(animated: false)
        //goDeletePage()
    }
    @objc func bgViewTapped(sender: UITapGestureRecognizer) {
        self.transparentView.isHidden = true
        self.dismiss(animated: false, completion: nil)
    }
}
