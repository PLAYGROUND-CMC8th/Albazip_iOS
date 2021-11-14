//
//  HomeManagerAddWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
protocol HomeManagerAddWorkSelectDelegate {
    func goAddPublicWork()
    func goAddPrivateWork()
}

class HomeManagerAddWorkVC: UIViewController{
    
    var transparentView = UIView()

    @IBOutlet var publicWorkView: UIView!
    @IBOutlet var privateWorkView: UIView!
    var delegate : HomeManagerAddWorkSelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( publicWorkViewTapped))
        publicWorkView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(privateWorkViewTapped))
        privateWorkView.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    @objc func publicWorkViewTapped(sender: UITapGestureRecognizer) {
        self.transparentView.isHidden = true
        self.delegate?.goAddPublicWork()
        dismiss(animated: false)
        
    }
    @objc func privateWorkViewTapped(sender: UITapGestureRecognizer) {
        self.transparentView.isHidden = true
        self.delegate?.goAddPrivateWork()
        dismiss(animated: false)
       
    }
}
