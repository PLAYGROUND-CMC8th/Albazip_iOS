//
//  MyPageManagerSelectPayTypeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/06.
//

import Foundation
import UIKit

protocol SelectPayTypeDelegate {
    func modalDismiss()
    func textFieldData(data: String)
}
//MyPageManagerPayTypeModalDelegate
class MyPageManagerSelectPayTypeVC: UIViewController{
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var cornerView: UIView!
    var selectPayTypeDelegate : SelectPayTypeDelegate?
    var payType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        view1.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(view2Tapped))
        view2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(view3Tapped))
        view3.addGestureRecognizer(tapGestureRecognizer3)
    }
    @objc func view1Tapped(sender: UITapGestureRecognizer) {
        view1.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setPayType(text : "시급")
    }
    
    @objc func view2Tapped(sender: UITapGestureRecognizer) {
        view2.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setPayType(text : "주급")
    }
    
    @objc func view3Tapped(sender: UITapGestureRecognizer) {
        view3.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setPayType(text : "월급")
    }
    
    func setPayType(text : String)  {
        selectPayTypeDelegate?.modalDismiss()
        selectPayTypeDelegate?.textFieldData(data: text)
        self.dismiss(animated: true, completion: nil)
    }
}
