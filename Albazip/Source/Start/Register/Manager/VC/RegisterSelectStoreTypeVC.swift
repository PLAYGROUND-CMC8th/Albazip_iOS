//
//  RegisterSelectStoreTypeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/25.
//

import Foundation
import UIKit

protocol ModalDelegate {
    func modalDismiss()
    func textFieldData(data: String)
}

class RegisterSelectStoreTypeVC: UIViewController{
    var modalDelegate : ModalDelegate?
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    
    @IBOutlet var cornerView: UIView!
    var storeType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        view1.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(view2Tapped))
        view2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(view3Tapped))
        view3.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(view4Tapped))
        view4.addGestureRecognizer(tapGestureRecognizer4)
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(view5Tapped))
        view5.addGestureRecognizer(tapGestureRecognizer5)
    }
    @objc func view1Tapped(sender: UITapGestureRecognizer) {
        view1.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setStoreType(text : "카페")
    }
    
    @objc func view2Tapped(sender: UITapGestureRecognizer) {
        view2.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setStoreType(text : "음식점")
    }
    
    @objc func view3Tapped(sender: UITapGestureRecognizer) {
        view3.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setStoreType(text : "판매업")
    }
    
    @objc func view4Tapped(sender: UITapGestureRecognizer) {
        view4.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setStoreType(text : "서비스업")
    }
    
    @objc func view5Tapped(sender: UITapGestureRecognizer) {
        view5.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setStoreType(text : "기타")
    }
    
    func setStoreType(text : String)  {
        modalDelegate?.modalDismiss()
        modalDelegate?.textFieldData(data: text)
        self.dismiss(animated: true, completion: nil)
    }
    
}
