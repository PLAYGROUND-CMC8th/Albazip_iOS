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
    func successDeletePosition()
}

class MyPageManagerWorkerPositionDeleteVC: UIViewController{
    
    var myPageManagerWorkerPositionDeleteAlertDelegate : MyPageManagerWorkerPositionDeleteAlertDelegate?
    var transparentView = UIView()
    var positionId = 0
    
    lazy var dataManager: MyPageDeletePositionDatamanager = MyPageDeletePositionDatamanager()
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
        showIndicator()
        dataManager.deletePosition(positionId: positionId, vc: self)
        
        /*
        self.transparentView.isHidden = true
        myPageManagerWorkerPositionDeleteAlertDelegate?.modalDismiss()
        
        
        self.dismiss(animated: false){
            self.myPageManagerWorkerPositionDeleteAlertDelegate?.nextDeleteModal()
        }
    */
}
}
extension MyPageManagerWorkerPositionDeleteVC {
    func didSuccessMyPageDeletePosition(result: MyPageStopWorkResponse) {
        print(result.message!)
        dismissIndicator()
        self.transparentView.isHidden = true
        self.myPageManagerWorkerPositionDeleteAlertDelegate?.successDeletePosition()
        dismiss(animated: true, completion: nil)
    }
    
    func failedToRequestMyPageDeletePosition(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
