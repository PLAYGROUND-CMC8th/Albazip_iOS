//
//  MyPageDetailStopWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//
protocol MyPageDetailStopWorkDelegate {
    func requestStopWork()
}
import Foundation
class MyPageDetailStopWorkVC: UIViewController{
    var transparentView = UIView()
    @IBOutlet var cornerView: UIView!
    @IBOutlet var backgroundView: UIView!
    var myPageDetailStopWorkDelegate : MyPageDetailStopWorkDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    @IBAction func btnNext(_ sender: Any) {
        self.transparentView.isHidden = true
        self.myPageDetailStopWorkDelegate?.requestStopWork()
        self.dismiss(animated: true)
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
}

