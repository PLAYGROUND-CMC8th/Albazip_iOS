//
//  BreakTimeBottomVC.swift
//  Albazip
//
//  Created by 김수빈 on 2022/10/25.
//

import Foundation
protocol BreakTimeDelegate: AnyObject {
    func modalDismiss()
}

class BreakTimeBottomVC: UIViewController{
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cornerView: UIView!
    weak var delegate: BreakTimeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        delegate?.modalDismiss()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnOk(_ sender: Any) {
        delegate?.modalDismiss()
        self.dismiss(animated: true)
    }
}
