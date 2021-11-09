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
}

class MyPageManagerWorkerPositionDeleteVC: UIViewController{
    
    var myPageManagerWorkerPositionDeleteAlertDelegate : MyPageManagerWorkerPositionDeleteAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        //myPageManagerWorkerPositionDeleteAlertDelegate?.imageModalDismiss()
        //selectProfileImageDelegate?.changeImage(data: mainImage.image!)
        //새로운 alert 창으로 이동
        // currentVC => FirstViewController
        
        let newStoryboard = UIStoryboard(name: "MyPageManagerStoryboard", bundle: nil)
        
        if let vc = newStoryboard.instantiateViewController(withIdentifier: "MyPageManagerWorkerPositionDelete2VC") as? MyPageManagerWorkerPositionDelete2VC {
            vc.modalPresentationStyle = .overFullScreen
        
        guard let pvc = self.presentingViewController else { return }

        self.dismiss(animated: false) {
          pvc.present(vc, animated: false, completion: nil)
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
}
}
