//
//  MyPageManagerWorkerPositionDeleteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import Foundation
import UIKit

protocol MyPageManagerWorkerPositionDeleteAlertDelegate {
    func modalDismiss()
    func nextDeleteModal()
}

class MyPageManagerWorkerPositionDeleteVC: UIViewController{
    
    var myPageManagerWorkerPositionDeleteAlertDelegate : MyPageManagerWorkerPositionDeleteAlertDelegate?
    var transparentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    @IBAction func btnCancel(_ sender: Any) {
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        
        /*
        let newStoryboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: nil)
        
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerPositionDelete2VC") as? MyPageManagerWorkerPositionDelete2VC {
            vc.modalPresentationStyle = .overFullScreen
            
        guard let pvc = self.presentingViewController else { return }
            
        self.transparentView.isHidden = true
        self.dismiss(animated: false) {
          pvc.present(vc, animated: false, completion: nil)
            
        }
        //self.dismiss(animated: true, completion: nil)
    }*/self.transparentView.isHidden = true
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        
        
        self.dismiss(animated: false){
            self.myPageManagerWorkerPositionDeleteAlertDelegate?.nextDeleteModal()
        }
    
}
}
