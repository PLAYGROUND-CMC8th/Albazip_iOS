//
//  MyPageManagerPositionDelete2VC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import Foundation
import UIKit

class MyPageManagerWorkerPositionDelete2VC: UIViewController {
    var myPageManagerWorkerPositionDeleteAlertDelegate : MyPageManagerWorkerPositionDeleteAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnCancel(_ sender: Any) {
        print("퇴사 취소")
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        print("퇴사 완료")
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        dismiss(animated: true, completion: nil)
    }
}
