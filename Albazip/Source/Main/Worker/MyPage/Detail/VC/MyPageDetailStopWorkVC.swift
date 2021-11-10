//
//  MyPageDetailStopWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

import Foundation
class MyPageDetailStopWorkVC: UIViewController{
    var transparentView = UIView()
    @IBOutlet var cornerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    
}
