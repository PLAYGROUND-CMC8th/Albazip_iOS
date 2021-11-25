//
//  MyPageManagerPositionDelete2VC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import Foundation
import UIKit
protocol MyPageManagerPositionDelete2VCDelegate {
    func successDeletePosition()
}

class MyPageManagerWorkerPositionDelete2VC: UIViewController {
    var positionId = 0
    var delegate: MyPageManagerPositionDelete2VCDelegate?
    lazy var dataManager: MyPageDeletePositionDatamanager = MyPageDeletePositionDatamanager()
    var transparentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    @IBAction func btnCancel(_ sender: Any) {
        print("퇴사 취소")
        //myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        self.transparentView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        print("퇴사 완료")
        //myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        showIndicator()
        dataManager.deletePosition(positionId: positionId, vc: self)
    }
}
extension MyPageManagerWorkerPositionDelete2VC {
    func didSuccessMyPageDeletePosition(result: MyPageStopWorkResponse) {
        print(result.message!)
        dismissIndicator()
        self.transparentView.isHidden = true
        self.delegate?.successDeletePosition()
        dismiss(animated: true, completion: nil)
    }
    
    func failedToRequestMyPageDeletePosition(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
