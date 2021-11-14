//
//  MyPageManagerWorkerExitVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/14.
//

import Foundation
class MyPageManagerWorkerExitVC: UIViewController{
    @IBOutlet var titleLabel: UILabel!
    var name = ""
    var transparentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "\(name)님이 퇴사 요청을 보냈어요."
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
